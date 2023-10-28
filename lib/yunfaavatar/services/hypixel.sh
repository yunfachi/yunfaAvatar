#!/usr/bin/env bash

INFO "Updating avatar in Hypixel"

fetch=$(curl -s \
  -b "xfNew_tfa_trust=${hypixel_cookie_xfNew_tfa_trust}; xfNew_user=${hypixel_cookie_xfNew_user}" \
  -c - \
  "${hypixel_url_fetch}" \
)

RESPONSE "HYPIXEL-FETCH" "${fetch}"

upload=$(curl -s \
  -H "Content-Type: multipart/form-data" \
  -b <(echo "$(sed -e '0,/^<\/html>$/d' -e '/^$/d' <<< $fetch)") \
  -F "_xfToken=$(grep -o 'data-csrf="[^"]*' <<< $fetch | grep -o '[^"]*$')" \
  -F "avatar_crop_x=0" \
  -F "avatar_crop_y=0" \
  -F "use_custom=1" \
  -F "upload=@${avatar}" \
  -F "_xfToken=$(grep -o 'data-csrf="[^"]*' <<< $fetch | grep -o '[^"]*$')" \
  -F "_xfResponseType=json" \
  "${hypixel_url_upload}" \
)

RESPONSE "HYPIXEL-UPLOAD" "${upload}"

INFO "Updated avatar in Hypixel"
