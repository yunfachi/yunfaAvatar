#!/usr/bin/env bash

INFO "Updating avatar in Steam"

upload=$(curl -s \
  -X POST \
  -H "Content-Type: multipart/form-data" \
  -b "sessionid=${steam_cookie_sessionid}; steamLoginSecure=${steam_cookie_steamLoginSecure};" \
  -F "type=player_avatar_image" \
  -F "sId=$(grep -oP '.*(?=%7C%7C)' <<< "${steam_cookie_steamLoginSecure}")" \
  -F "sessionid=${steam_cookie_sessionid}" \
  -F "doSub=1" \
  -F "avatar=@${avatar}" \
  "${steam_url_upload}" \
)

RESPONSE "STEAM-UPLOAD" "${upload}"

INFO "Updated avatar in Steam"
