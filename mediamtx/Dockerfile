FROM bluenviron/mediamtx:latest

# Default configuration via environment variables
# See: https://github.com/bluenviron/mediamtx#configuration

# Termination at reverse proxy (Cloudflare->Traefik) means HTTPS at edge, HTTP inside
ENV MTX_WEBRTC_ENCRYPTION=optional \
    MTX_WEBRTC_ALLOWORIGIN=https://prekestudio.itagenten.no \
    MTX_PATHS_ALL_OTHERS_SOURCE=publisher \
    MTX_WEBRTC_ICESERVERS=["stun:stun.l.google.com:19302","stun:stun.cloudflare.com:3478"] \
    MTX_WEBRTC_ADDITIONALHEADERS={"Access-Control-Allow-Headers":"content-type"}

# Allow extra headers for WHIP/WHEP if a preflight complains
# ENV MTX_WEBRTC_ADDITIONALHEADERS={"Access-Control-Allow-Headers":"content-type"}

EXPOSE 8889

# mediamtx is the default entrypoint/cmd

