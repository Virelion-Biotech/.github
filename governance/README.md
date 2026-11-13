# Virelion organization security and repository governance

This directory contains the recommended organization-wide main-branch ruleset and the administrator script that creates a repository-specific ruleset for the 22-repository HeartTwin ecosystem.

## 1. Apply main-branch rulesets

The GitHub connector available to the maintenance workflow can read rulesets but cannot create organization rulesets. An organization owner must apply them with a GitHub CLI token that has organization administration permission.

From a machine with GitHub CLI (gh) and jq installed:

```bash
gh auth login
bash governance/apply-main-rulesets.sh
```

The script:
- targets the default branch of each listed repository;
- discovers successful job check names from the latest successful main-branch push workflow whose name resembles CI/tests;
- requires those checks, one approving review, approval after the latest push, and resolution of review conversations;
- blocks force pushes and branch deletion;
- creates or updates one organization ruleset per repository;
- skips a repository rather than creating a ruleset with an empty or guessed check list.

Run it from a clone of this repository. Review the generated rulesets in Organization Settings → Rules → Rulesets after execution.

**Do not apply the rulesets before every repository has at least one successful default-branch CI/test run with stable job names.** Verify the selected checks and test a pull request before relying on enforcement.

## 2. Turn on GitHub security features

For every repository, an organization owner should enable:
- Dependabot alerts;
- Dependabot security updates;
- secret scanning;
- secret scanning push protection;
- private vulnerability reporting.

These are repository/org security settings. A committed .github/dependabot.yml configures version-update schedules; it does not, by itself, enable Dependabot alerts or secret scanning.

## 3. Permissions and actions

Use explicit least-privilege workflow permissions. Workflows should default to contents: read; grant write permissions only to the individual job that creates a dependency-update pull request or publishes a release.

Third-party actions and security scanner images should be pinned to immutable commit or digest references and updated through Dependabot.

## 4. Required status checks

The ruleset script derives the required check contexts from the most recent successful main-branch CI/test workflow for each repository. If a repository has no matching successful workflow, the script skips it. Do not replace a missing check with a guessed context.

After each repository changes its CI job names, rerun the script or update the ruleset manually so that required checks remain accurate.


## 5. Apply repository security settings

Run the security-settings script separately from a machine with GitHub CLI (gh) and jq installed:

```bash
gh auth login
bash governance/enable-security-features.sh
```

The script requests Dependabot alerts, Dependabot security updates, native secret scanning, secret-scanning push protection, and private vulnerability reporting for each of the 22 repositories. It reports per-repository failures; a failure is not silently treated as enabled. These are GitHub repository settings, not repository files. Review any eligibility or plan errors returned by GitHub.
