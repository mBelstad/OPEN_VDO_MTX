# MediaMTX sub-app (Coolify)

This packages MediaMTX with defaults that work behind Cloudflare + Coolify.

## Deploy steps (Coolify)

1. New Application → Source: Git → this repo → path `mediamtx/`.
2. Build pack: Dockerfile.
3. Container/Internal port: 8889.
4. Domain: set a subdomain in Coolify (example: `sfu.itagenten.no`).
5. In Cloudflare DNS, point the subdomain to Coolify. Proxied (orange cloud) works with Traefik handling TLS; DNS-only also works if preferred.
6. Environment overrides (optional):
   - `MTX_WEBRTC_ALLOWORIGIN`: your UI origin, e.g. `https://prekestudio.itagenten.no`
   - `MTX_WEBRTC_ICESERVERS`: JSON array of STUN/TURN servers
   - `MTX_WEBRTC_ADDITIONALHEADERS`: `{"Access-Control-Allow-Headers":"content-type"}`

Traefik (Coolify) terminates TLS on 443 and proxies to port 8889 within the container.

## Using with VDO.Ninja

- Publish: open VDO.Ninja with `&push=<id>&mediamtx=sfu.itagenten.no`
- Share WHEP link: the app will show `https://sfu.itagenten.no/<id>/whep` for viewers.
- Local dev: `&mediamtx=localhost:8889` forces HTTP and default port.

## Notes

- WHIP/WHEP endpoints follow `https://<domain>/<stream-id>/whip` and `/whep`.
- Do not append ports when using a domain behind Coolify/Traefik.
- Public firewall only needs 443 to the Coolify reverse proxy; container’s 8889 stays internal.
