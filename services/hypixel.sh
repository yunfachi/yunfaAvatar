#!/usr/bin/env bash

INFO "Updating avatar in Hypixel"

fetch=$(curl -s \
  -b "xfNew_tfa_trust=${hypixel_tfa}; xfNew_user=${hypixel_id}%2C${hypixel_auth}" \
  -c - \
  $hypixel_fetchurl \
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
  $hypixel_uploadurl \
)

RESPONSE "HYPIXEL-UPLOAD" "${upload}"

INFO "Updated avatar in Hypixel"
