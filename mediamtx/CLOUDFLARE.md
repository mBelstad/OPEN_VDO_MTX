# Cloudflare + MediaMTX (WHIP/WHEP)

This repo targets deployment behind Coolify's Traefik with a Cloudflare-managed domain.

## DNS

- Create a subdomain `sfu.example.com` in Cloudflare DNS.
- Point it to your Coolify host (A/AAAA record). Proxied (orange cloud) or DNS-only both work for the HTTP parts.
- The WHIP/WHEP HTTP requests go over HTTPS on port 443 to Traefik → container:8889.

## WebRTC UDP considerations

- WebRTC media flows are UDP peer-to-peer with MediaMTX; Cloudflare does not proxy UDP.
- Ensure your server's firewall allows the UDP range you configure in MediaMTX.
- If behind NAT, configure MediaMTX to advertise the public IP (see MediaMTX docs for WebRTC NAT/ICE settings).

Tips:

- If clients can negotiate but video never flows, open a narrow UDP range on the host and configure MediaMTX to use it; then allow inbound on that range.
- Use public STUN servers (default provided) or your own TURN if required.

## Links

- MediaMTX WebRTC configuration: refer to the official documentation for NAT/ICE and UDP port range.
- VDO.Ninja WHIP/WHEP usage: see `../MEDIAMTX_VDONINJA.md`.
