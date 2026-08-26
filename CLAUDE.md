# laitto-keycloak

Identity & access management for the Laitto brewing-control platform. Provides the
OIDC realm used by `laitto-backend-services` (OIDC) and `laitto-ui` (keycloak-js).

## Contents
- `realm-config/` — realm definition imported on startup: `laitto-realm.json` (and `laitto.yaml`).
- `themes/laitto/` — custom Keycloak login/UI theme.
- `Dockerfile` — image bundling the custom theme.
- `docker-compose.yml` — local dev: Keycloak `26.7.2`, `start-dev --import-realm`, on **port 8180** (admin/admin). Theme caching is disabled for hot-reload.

## Local dev
- `docker compose up` → Keycloak at http://localhost:8180 (admin / admin).
- Realm `laitto` is auto-imported from `realm-config/` on first start.
- `themes/` is volume-mounted, so theme edits show up without a rebuild.

## Notes
- In production the realm/Keycloak is deployed via `laitto-charts` (custom in-repo Keycloak chart wired to MariaDB, since Bitnami's chart only supports PostgreSQL).

## Versions — where the server version actually comes from
- **The running production version is this repo's `Dockerfile` `FROM`** (currently `26.7.2`), because
  `values-production.yaml` overrides the image to `ghcr.io/anttileppa/laitto-keycloak:main`. The
  chart's own `keycloak.image.tag` is only the stock-install default — keep the two in step anyway.
- **`keycloak-js` does not track server releases.** Its newest published version is `26.2.4`, so the
  UI stays there; it speaks standard OIDC and works against a newer server. A version gap between
  the two is expected, not drift.
- **`keycloak-config-cli` is pinned to the Keycloak *major*** (`adorsys/keycloak-config-cli:6.5.1-26`
  in `laitto-charts`). Its newest version-specific build targets 26.5.5, so the floating `-26` tag is
  what a 26.7 server gets. Verified working against 26.7.2 — but **re-check it before any future
  Keycloak bump**: it applies the realm on every deploy, so if it breaks, the server upgrades with
  its realm config only half-applied.
- The login theme overlays `keycloak.v2` and recolors **PatternFly v5** variables
  (`--pf-v5-global--*`). Confirm PatternFly's major hasn't moved after an upgrade, or the recolor
  silently reverts toward stock Keycloak without erroring.
