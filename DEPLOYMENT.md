## Deploying OPEN_VDO_MTX to Coolify (Ubuntu) behind Cloudflare

This repo is a static web app. We ship it in a tiny Nginx container.

### 1) DNS in Cloudflare
- Create or pick new subdomains on `itagenten.no` for this app. Suggestions:
  - `prekestudio.itagenten.no` (main UI)
  - `vdo2.itagenten.no` (alt name if `vdo` is taken)
  - Optional later: `wss.itagenten.no` (signaling, if you self-host a websocket server), `sfu.itagenten.no` (MediaMTX), `whip.itagenten.no`/`whep.itagenten.no` (ingest/playback)
- In Cloudflare DNS:
  - Add an A record for `prekestudio.itagenten.no` pointing to `65.109.32.111`.
  - Keep Proxy ON (orange cloud) so Cloudflare terminates TLS and proxies HTTP/WebSocket.

### 2) Hetzner firewall
Open inbound TCP 80 and 443 to the server. Optionally restrict to Cloudflare IP ranges for stricter security.

### 3) Coolify app (GitHub deploy)
- Create Application → Source: Git → Connect this GitHub repo.
- Build Pack: Dockerfile (root-level `Dockerfile`)
- Container port: 80
- Domains: add `prekestudio.itagenten.no`.
- Deploy.

### 4) Cloudflare settings (recommended)
- SSL/TLS: Full (strict) if you terminate TLS at Cloudflare and origin has certs; otherwise Full.
- Network: WebSockets ON, HTTP/2 and HTTP/3 ON, Brotli ON.
- Caching: Standard is fine. You can enable `Cache Everything` on static assets if desired.

### 5) About signaling and media backends
By default, the UI can use public VDO.Ninja infrastructure (various `*.vdo.ninja` endpoints) unless you override via URL params or code. If you want everything under your domain:
- WebSocket handshake server: deploy `wss.yourdomain` from `https://github.com/steveseguin/websocket_server` and set `&wss=wss.yourdomain:443` via URL or in code.
- MediaMTX SFU: host your own and set `session.mediamtx = "sfu.yourdomain:443"` in `index.html`/`room.html` (or use URL params where supported).
- WHIP/WHEP: host own endpoints and update references (search for `whip`/`whep`).

These are optional. You can start with only the static UI on your domain and iterate later.

### 6) Nginx inside the container
We serve files from `/usr/share/nginx/html` with sensible caching and security headers. If some advanced demos need SharedArrayBuffer (cross-origin isolation), you may need to selectively enable COOP/COEP headers. See `nginx.conf` notes.

### 7) Common issues
- 404s on wasm: ensure MIME `application/wasm` is served (added).
- Cross-origin isolation errors: either disable strict COOP/COEP or add them only to routes that load SAB-enabled demos and make sure all subresources allow it.
- WebSocket blocked: confirm Cloudflare WebSockets is ON and your Hetzner firewall allows 80/443.

### 8) Redeploy flow
- Push to `main` (or your chosen branch). Coolify will auto-build and deploy.
- For faster images, `.dockerignore` excludes non-runtime files.

---

If you want me to wire custom subdomains directly into the UI (replace defaults, set `session.wss`, `session.mediamtx`, etc.), tell me which exact hostnames you want and I’ll edit the relevant files.
