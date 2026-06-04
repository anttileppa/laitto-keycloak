# laitto-keycloak

Identity & access management for the Laitto brewing-control platform. Provides the
OIDC realm used by `laitto-backend-services` (OIDC) and `laitto-ui` (keycloak-js).

## Contents
- `realm-config/` — realm definition imported on startup: `laitto-realm.json` (and `laitto.yaml`).
- `themes/laitto/` — custom Keycloak login/UI theme.
- `Dockerfile` — image bundling the custom theme.
- `docker-compose.yml` — local dev: Keycloak `26.2.4`, `start-dev --import-realm`, on **port 8180** (admin/admin). Theme caching is disabled for hot-reload.

## Local dev
- `docker compose up` → Keycloak at http://localhost:8180 (admin / admin).
- Realm `laitto` is auto-imported from `realm-config/` on first start.
- `themes/` is volume-mounted, so theme edits show up without a rebuild.

## Notes
- In production the realm/Keycloak is deployed via `laitto-charts` (custom in-repo Keycloak chart wired to MariaDB, since Bitnami's chart only supports PostgreSQL).
- Keep the realm version (`26.2.4`) aligned with `keycloak-js` in the UI and the OIDC config in services.
