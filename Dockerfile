FROM quay.io/keycloak/keycloak:26.6.2

# Copy custom theme into Keycloak's theme directory
COPY themes /opt/keycloak/themes

# Build an optimised Keycloak binary (picks up the theme at build time)
RUN /opt/keycloak/bin/kc.sh build

ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
CMD ["start"]
