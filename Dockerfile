# Multi-stage build not required; static assets only
FROM nginx:1.27-alpine

# Set nginx to run as non-root where possible
# (nginx in alpine runs as uid 101 by default for worker processes)

ARG APP_DIR=/usr/share/nginx/html

# Copy our custom nginx config (added in next edit)
COPY nginx.conf /etc/nginx/nginx.conf

# Copy project static files
COPY . ${APP_DIR}

# Remove files not needed in container at runtime
RUN rm -f ${APP_DIR}/turn-credentials-php.sample \
    ${APP_DIR}/turnserver_install.sh.sample \
    ${APP_DIR}/turnserver_basic.conf \
    ${APP_DIR}/turnserver.md || true

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=3s CMD wget -qO- http://127.0.0.1/ || exit 1

CMD ["nginx", "-g", "daemon off;"]


