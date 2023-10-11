#!/usr/bin/env bash

INFO "Updating avatar in Discord"

upload=$(curl -s \
  -X PATCH \
  -d "@${TEMP_DIR}/avatar.json" \
  -H "Content-Type: application/json" \
  -H "Authorization: ${discord_header_Authorization}" \
  -H "X-Super-Properties: ${discord_header_X_Super_Properties}" \
  "${discord_url_upload}"
)

RESPONSE "DISCORD-UPLOAD" "${upload}"

INFO "Updated avatar in Discord"
