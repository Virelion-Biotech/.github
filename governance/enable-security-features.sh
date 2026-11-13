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

success=0
failed=0
payload_file="$(mktemp)"
trap 'rm -f "$payload_file"' EXIT

jq -n '{
  security_and_analysis: {
    secret_scanning: {status: "enabled"},
    secret_scanning_push_protection: {status: "enabled"}
  }
}' >"$payload_file"

for repository in "${REPOSITORIES[@]}"; do
  echo
  echo "==> ${ORG}/${repository}"
  repo_failed=0

  # Enable the repository-level Dependabot alert feed and automated security PRs.
  if gh api --silent --method PUT "repos/${ORG}/${repository}/vulnerability-alerts" >/dev/null; then
    echo "Dependabot alerts: enabled"
  else
    echo "Dependabot alerts: FAILED"
    repo_failed=1
  fi

  if gh api --silent --method PUT "repos/${ORG}/${repository}/automated-security-fixes" >/dev/null; then
    echo "Dependabot security updates: enabled"
  else
    echo "Dependabot security updates: FAILED"
    repo_failed=1
  fi

  # Enable native secret scanning and push protection for these public repositories.
  if gh api --silent --method PATCH "repos/${ORG}/${repository}" --input "$payload_file" >/dev/null; then
    echo "Secret scanning and push protection: enabled"
  else
    echo "Secret scanning and push protection: FAILED (check plan/permissions and repository security settings)"
    repo_failed=1
  fi

  # Private vulnerability reporting is a distinct repository setting.
  if gh api --silent --method PUT "repos/${ORG}/${repository}/private-vulnerability-reporting" >/dev/null; then
    echo "Private vulnerability reporting: enabled"
  else
    echo "Private vulnerability reporting: FAILED (check repository eligibility and permissions)"
    repo_failed=1
  fi

  if [[ "$repo_failed" -eq 0 ]]; then
    success=$((success + 1))
  else
    failed=$((failed + 1))
  fi
done

echo
echo "Completed: ${success} repositories fully configured; ${failed} repositories require manual follow-up."
if [[ "$failed" -gt 0 ]]; then
  exit 1
fi
