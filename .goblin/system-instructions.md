# Laitto Keycloak Executor Instructions

These instructions apply when implementing work in `anttileppa/laitto-keycloak`.

## Scope Rules

- Changes here affect authentication and identity across the platform.
- Keep modifications narrow and reviewable.

## Validation

Required before PR:

- `docker compose config`

If the task needs a live Keycloak runtime verification that cannot be run safely, document that explicitly.

## Escalate When

- The task changes security model, realm-wide auth flow, or broad client integration behavior.
- The task requires coordinated backend/UI/mobile changes to stay correct.

## Existing PR Handling

- Reuse the same branch and PR if one already exists.
- Address review comments first.
- If no review comments exist, inspect failed checks and fix the underlying issue if in scope.

## PR Expectations

- Open a draft PR.
- Include `Part of anttileppa/laitto#<issue-number>` in the PR body.
- Describe the realm/theme change and how it was checked.