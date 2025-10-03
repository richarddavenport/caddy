# Caddy with Nonstandard Plugins

[![Build and Publish Docker Image](https://github.com/richarddavenport/caddy/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/richarddavenport/caddy/actions/workflows/docker-publish.yml)

A custom Caddy build that includes the rate limiting plugin for enhanced traffic control and DDoS protection.

## Features

- 🚀 **Caddy 2** - Modern, automatic HTTPS web server
- 🛡️ **Rate Limiting** - Built-in rate limiting capabilities via [caddy-ratelimit](https://github.com/mholt/caddy-ratelimit)
- 🔒 **Security Hardened** - Updated base image with latest security patches
- 🐳 **Multi-architecture** - Supports both AMD64 and ARM64 architectures
- 📦 **GitHub Container Registry** - Automatically built and published

## Quick Start

### Using Docker

```bash
docker run -d \
  --name caddy \
  -p 80:80 \
  -p 443:443 \
  -v $PWD/Caddyfile:/etc/caddy/Caddyfile \
  -v caddy_data:/data \
  -v caddy_config:/config \
  ghcr.io/richarddavenport/caddy:latest
```

### Using Docker Compose

```yaml
version: '3.8'

services:
  caddy:
    image: ghcr.io/richarddavenport/caddy:latest
    container_name: caddy
    restart: unless-stopped
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./Caddyfile:/etc/caddy/Caddyfile
      - caddy_data:/data
      - caddy_config:/config
    networks:
      - caddy

volumes:
  caddy_data:
  caddy_config:

networks:
  caddy:
    external: true
```

## Rate Limiting Configuration

The rate limiting plugin allows you to control traffic flow. Here's an example Caddyfile configuration:

```caddy
example.com {
    # Basic rate limiting: 10 requests per second per IP
    rate_limit {
        zone static_ip {
            key {remote_ip}
            events 10
            window 1s
        }
    }
    
    # Advanced rate limiting with different zones
    rate_limit {
        zone api {
            key {remote_ip}
            events 100
            window 1m
        }
        zone api_burst {
            key {remote_ip}
            events 20
            window 1s
        }
    }
    
    reverse_proxy localhost:8080
}
```

### Rate Limiting Options

- **key**: What to rate limit by (IP, header, etc.)
- **events**: Number of allowed events
- **window**: Time window for the limit
- **distributed**: Enable distributed rate limiting (for multiple instances)

## Available Tags

- `latest` - Latest build from main branch
- `v1.0.0`, `v1.0`, `v1` - Semantic version tags
- `main` - Latest commit from main branch

## Building Locally

```bash
# Clone the repository
git clone https://github.com/richarddavenport/caddy.git
cd caddy

# Build the image
docker build -t caddy .

# Run locally
docker run -d \
  --name caddy-local \
  -p 80:80 \
  -p 443:443 \
  -v $PWD/Caddyfile:/etc/caddy/Caddyfile \
  caddy
```

## Included Plugins

This custom build includes the following plugins beyond the standard Caddy distribution:

- **[caddy-ratelimit](https://github.com/mholt/caddy-ratelimit)** - Advanced rate limiting and traffic shaping

## Security

This image is built with security in mind:

- ✅ Based on Alpine Linux for minimal attack surface
- ✅ Regular security updates applied automatically
- ✅ Non-root user execution
- ✅ Distroless final image where possible

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

- 📖 [Caddy Documentation](https://caddyserver.com/docs/)
- 🛡️ [Rate Limit Plugin Documentation](https://github.com/mholt/caddy-ratelimit)
- 🐛 [Report Issues](https://github.com/richarddavenport/caddy/issues)

## Acknowledgments

- [Caddy Server](https://caddyserver.com/) - The amazing web server this is based on
- [Matt Holt](https://github.com/mholt) - For the rate limiting plugin
- [xcaddy](https://github.com/caddyserver/xcaddy) - For making custom builds easy
