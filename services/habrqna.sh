#!/usr/bin/env bash

INFO "Updating avatar in Habr Q&A"

upload=$(curl -s \
  -X POST \
  -H "Content-Type: multipart/form-data" \
  -b "toster_sid=${habrqna_cookie_toster_sid}" \
  -F "files=@${avatar}" \
  "${habrqna_url_upload}" \
)

RESPONSE "HABRQNA-UPLOAD" "${upload}"

fetch=$(curl -s \
  -X GET \
  -b "toster_sid=${habrqna_cookie_toster_sid}" \
  "${habrqna_url_fetch}" \
)

RESPONSE "HABRQNA-FETCH" "${fetch}"

save=$(curl -s \
  -X POST \
  -H "Referer: https://qna.habr.com/my/profile" \
  -b "toster_sid=${habrqna_cookie_toster_sid}" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -H "x-form-token: $(sed -n '/token/s/.*action="my\/save_profile"\s\method="post"\s\+data-token="\([^"]\+\).*/\1/p' <<< $fetch)" \
  -d "avatar_url=$(sed -E 's/\\//g
               s/.*"url":"?([^,"]*)"?.*/\1/' <<< $upload)&\
  avatar=upload&\
  firstname=$(grep -oP '(?<=name="firstname" type="text" value=")[^"]*' <<< "${fetch}")&\
  lastname=$(grep -oP '(?<=name="lastname" type="text" value=")[^"]*' <<< "${fetch}")&\
  short_about=$(grep -oP '(?<=name="short_about" type="text" value=")[^"]*' <<< "${fetch}")&\
  about=$(grep -oP '(?<=name="about" rows="5">)[^<]*' <<< "${fetch}")&\
  place%5Bcountry%5D=0" \
  "${habrqna_url_save}" \
)

RESPONSE "HABRQNA-SAVE" "${save}"

INFO "Updated avatar in Habr Q&A"
