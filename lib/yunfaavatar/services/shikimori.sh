#!/usr/bin/env bash

INFO "Updating avatar in Shikimori"

fetch=$(curl -s \
  -X GET \
  -b "_kawai_session=${shikimori_cookie_kawai_session}" \
  "${shikimori_url_fetch}" \
)

RESPONSE "SHIKIMORI-FETCH" "${fetch}"

upload=$(curl -s \
  -X POST \
  -H "Content-Type: multipart/form-data" \
  -b "_kawai_session=${shikimori_cookie_kawai_session}" \
  -F "_method=patch" \
  -F "authenticity_token=$(grep -oP '(?<=<meta name="csrf-token" content=")[^"]*' <<< "${fetch}")" \
  -F "user[avatar]=@${avatar}" \
  "$(grep -oP '(?<=<a class="submenu-triangle" href=")[^"]*' <<< "${fetch}")" \
)

RESPONSE "SHIKIMORI-UPLOAD" "${upload}"

INFO "Updated avatar in Shikimori"