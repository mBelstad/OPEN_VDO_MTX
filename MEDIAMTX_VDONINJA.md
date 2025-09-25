# VDO.Ninja + MediaMTX quick guide

This shows how to publish from VDO.Ninja (or your fork UI) to your MediaMTX instance (Coolify) and share a WHEP viewer URL.

## Publish to MediaMTX (WHIP)

- Open VDO.Ninja and add `&push=<stream-id>&mediamtx=<your-sfu-domain>`
- Example (your UI):
  - `https://prekestudio.itagenten.no/?push=demo123&mediamtx=sfu.itagenten.no:8890`
  
  Example (vdo.ninja):
  - `https://vdo.ninja/?push=demo123&mediamtx=sfu.itagenten.no`
- The app constructs the WHIP endpoint as (MediaMTX format):
  - `https://sfu.itagenten.no:8890/whip/demo123`

Optional output tuning via URL params:

- `&whipoutvideobitrate=2500` (kbps)
- `&whipoutcodec=vp9` (try `vp9`, `av1`, `h264` depending on browser)
- `&whipoutaudiobitrate=128`
- `&whipoutkeyframe=2` (seconds)

## Share or play (WHEP)

- WHEP share URL format (MediaMTX format):
  - `https://sfu.itagenten.no:8890/whep/<stream-id>`
- Example:
  - `https://sfu.itagenten.no:8890/demo123/whep`

Use VDO.Ninja as a WHEP player:

- `https://prekestudio.itagenten.no/?whep=https://sfu.itagenten.no:8890/whep/demo123`
  
  or using vdo.ninja:
  
  - `https://vdo.ninja/?whep=https://sfu.itagenten.no:8890/whep/demo123`
  - `?whepplay=` also works.

## Local development

- Run MediaMTX locally on port 8889 and use:
  - `https://vdo.ninja/?push=dev1&mediamtx=localhost:8889`
- The app will use HTTP for localhost and HTTPS for domains automatically.

## Notes

- WHIP/WHEP are HTTP endpoints; actual media flows use UDP via WebRTC.
- If the server is public, ensure the UDP port range is reachable and configured in MediaMTX.
- See `mediamtx/CLOUDFLARE.md` for DNS and UDP guidance.
