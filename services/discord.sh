#!/usr/bin/env bash

INFO "Updating avatar in Discord"

upload=$(curl -s \
  -X PATCH \
  -d "@${TEMP_DIR}/avatar.json" \
  -H "Content-Type: application/json" \
  -H "Authorization: ${discord_auth}" \
  -H "X-Super-Properties: ${discord_properties}" \
  $discord_uploadurl
)

RESPONSE "DISCORD-UPLOAD" "${upload}"

INFO "Updated avatar in Discord"
