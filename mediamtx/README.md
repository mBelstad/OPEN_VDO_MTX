# MediaMTX sub-app (Coolify)

This packages MediaMTX with defaults that work behind Cloudflare + Coolify.

## Deploy steps (Coolify)
1. New Application → Source: Git → this repo → path `mediamtx/`.
2. Build pack: Dockerfile.
3. Container/Internal port: 8889.
4. Domain: `sfu.itagenten.no` (proxy ON in Cloudflare).
5. Environment overrides (optional):
   - `MTX_WEBRTC_ALLOWORIGIN`: set to your UI origin, e.g. `https://prekestudio.itagenten.no`
   - `MTX_WEBRTC_ICESERVERS`: JSON array of STUN/TURN servers
   - `MTX_WEBRTC_ADDITIONALHEADERS`: `{"Access-Control-Allow-Headers":"content-type"}`

Traefik (Coolify) terminates TLS on 443 and proxies to port 8889.

## Notes
- WHIP/WHEP: use `https://sfu.itagenten.no/<stream-id>/whip` and `/whep`.
- In the UI, set `&mediamtx=sfu.itagenten.no` (port not required) or use the helper panel.
- Keep Hetzner firewall open for 443 to the Coolify host. No 8889 public exposure needed.
