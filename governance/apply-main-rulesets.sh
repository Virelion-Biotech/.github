#!/usr/bin/env bash
set -Eeuo pipefail

ORG="${GITHUB_ORG:-Virelion-Biotech}"
REPOSITORIES=(
  Virelion-HeartTwin
  Virelion-CardiAnatomy
  Virelion-CardiAtlas
  Virelion-CardiBench
  Virelion-CardiBridge
  Virelion-CardiEP
  Virelion-CardiEval
  Virelion-CardiFlow
  Virelion-CardiInfer
  Virelion-CardiLearn
  Virelion-CardiMech
  Virelion-CardiSim
  Virelion-CardiStudio
  Virelion-CardiTherapy
  Virelion-CardiTrace
  Virelion-CardiVex
  Virelion-CardiAgent
  Virelion-CardioScore
  Virelion-DCCP
  Virelion-ElectroTrace
  Virelion-MyoTrace
  Virelion-OptiCell
)

command -v gh >/dev/null || { echo "GitHub CLI (gh) is required." >&2; exit 2; }
command -v jq >/dev/null || { echo "jq is required." >&2; exit 2; }
gh auth status >/dev/null

created=0
skipped=0
failed=0

for repository in "${REPOSITORIES[@]}"; do
  echo
  echo "==> ${ORG}/${repository}"

  if ! runs="$(gh api "repos/${ORG}/${repository}/actions/runs" -f branch=main -f event=push -f per_page=100 2>/dev/null)"; then
    echo "SKIP: cannot read workflow runs."
    skipped=$((skipped + 1))
    continue
  fi

  run="$(jq -c '
    [.workflow_runs[]
      | select(.status == "completed" and .conclusion == "success")
      | select(.name | test("(^ci$|test|quality|check)"; "i"))]
    | sort_by(.created_at)
    | last // empty
  ' <<<"$runs")"

  if [[ -z "$run" || "$run" == "null" ]]; then
    echo "SKIP: no successful main-branch CI/test workflow found."
    skipped=$((skipped + 1))
    continue
  fi

  run_id="$(jq -r '.id' <<<"$run")"
  run_name="$(jq -r '.name' <<<"$run")"
  echo "Selected workflow: ${run_name} (run ${run_id})"

  if ! jobs="$(gh api "repos/${ORG}/${repository}/actions/runs/${run_id}/jobs" -f per_page=100 2>/dev/null)"; then
    echo "SKIP: cannot read jobs for selected workflow."
    skipped=$((skipped + 1))
    continue
  fi

  checks="$(jq -c '
    [.jobs[]
      | select(.status == "completed" and .conclusion == "success")
      | {context: .name}]
    | unique_by(.context)
  ' <<<"$jobs")"

  if [[ "$(jq 'length' <<<"$checks")" -eq 0 ]]; then
    echo "SKIP: selected workflow has no successful job checks."
    skipped=$((skipped + 1))
    continue
  fi

  ruleset_name="Virelion main protection - ${repository}"
  payload_file="$(mktemp)"
  response_file="$(mktemp)"

  jq -n     --arg name "$ruleset_name"     --arg repository "$repository"     --argjson checks "$checks"     '{
      name: $name,
      target: "branch",
      enforcement: "active",
      conditions: {
        repository_name: {
          include: [$repository],
          exclude: [],
          protected: false
        },
        ref_name: {
          include: ["~DEFAULT_BRANCH"],
          exclude: []
        }
      },
      rules: [
        {type: "deletion"},
        {type: "non_fast_forward"},
        {
          type: "pull_request",
          parameters: {
            required_approving_review_count: 1,
            dismiss_stale_reviews_on_push: true,
            require_code_owner_review: false,
            require_last_push_approval: true,
            required_review_thread_resolution: true,
            allowed_merge_methods: ["merge", "squash", "rebase"]
          }
        },
        {
          type: "required_status_checks",
          parameters: {
            required_status_checks: $checks,
            strict_required_status_checks_policy: true
          }
        }
      ],
      bypass_actors: []
    }' >"$payload_file"

  existing_id="$(gh api --paginate "orgs/${ORG}/rulesets?per_page=100" 2>/dev/null     | jq -r --arg name "$ruleset_name" '.[] | select(.name == $name) | .id'     | head -n 1 || true)"

  if [[ -n "$existing_id" ]]; then
    method="PUT"
    endpoint="orgs/${ORG}/rulesets/${existing_id}"
    operation="updated"
  else
    method="POST"
    endpoint="orgs/${ORG}/rulesets"
    operation="created"
  fi

  if gh api --method "$method" "$endpoint" --input "$payload_file" >"$response_file"; then
    ruleset_id="$(jq -r '.id // "unknown"' "$response_file")"
    echo "SUCCESS: ${operation} ruleset ${ruleset_id}; required checks: $(jq -r '[.[].context] | join(", ")' <<<"$checks")"
    created=$((created + 1))
  else
    echo "FAILED: could not ${operation} ruleset. Check organization administration permission and API response."
    failed=$((failed + 1))
  fi

  rm -f "$payload_file" "$response_file"
done

echo
echo "Completed: ${created} rulesets created/updated; ${skipped} skipped; ${failed} failed."
if [[ "$failed" -gt 0 ]]; then
  exit 1
fi
