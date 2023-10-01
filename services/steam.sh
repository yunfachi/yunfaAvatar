#!/usr/bin/env bash

INFO "Updating avatar in Steam"

upload=$(curl -s \
  -X POST \
  -H "Content-Type: multipart/form-data" \
  -b "sessionid=${steam_sessionid}; steamLoginSecure=${steam_id64}%7C%7C${steam_auth};" \
  -F "type=player_avatar_image" \
  -F "sId=${steam_id64}" \
  -F "sessionid=${steam_sessionid}" \
  -F "doSub=1" \
  -F "avatar=@${avatar}" \
  $steam_uploadurl \
)

RESPONSE "STEAM-UPLOAD" "${upload}"

INFO "Updated avatar in Steam"
