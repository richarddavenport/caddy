# Custom Caddy build with rate limiting plugin
FROM caddy:2-builder AS builder

RUN xcaddy build \
    --with github.com/mholt/caddy-ratelimit

FROM caddy:2-alpine

# Update packages to address vulnerabilities
RUN apk update && apk upgrade --no-cache

COPY --from=builder /usr/bin/caddy /usr/bin/caddy