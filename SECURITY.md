# Security policy

## Supported repositories

This policy applies to Virelion-Biotech repositories unless a repository publishes a more specific security policy.

## Reporting a vulnerability

Please do not open a public issue for an unpatched vulnerability or publish proof-of-concept exploit details.

Use GitHub's **Report a vulnerability** feature in the affected repository when private vulnerability reporting is enabled. If that option is unavailable, contact an organization owner privately through GitHub and include:
- the affected repository and commit or release;
- the impact and affected component;
- concise reproduction steps;
- any suggested mitigation.

Do not include patient-identifiable information, credentials, tokens, or private datasets in a report.

## Response and remediation

The maintainers will triage reports, determine affected versions, coordinate remediation, and publish an advisory when appropriate. A fix is not considered complete until the affected package or workflow has been patched and its relevant tests pass.

## Secret exposure

If a credential is suspected to be exposed, revoke or rotate it immediately at the issuing provider. Removing a secret from the latest source tree does not invalidate copies in Git history, forks, logs, artifacts, or caches.
