#!/usr/bin/env bash

INFO "Updating avatar in GitHub"

fetch=$(curl -s \
  -X GET \
  -b "user_session=${github_cookie_user_session}; __Host-user_session_same_site=${github_cookie_user_session}" \
  "${github_url_fetch}" \
)

#RESPONSE "GITHUB-FETCH" "${fetch}"

create=$(curl -s \
  -X POST \
  -H "Content-Type: multipart/form-data" \
  -b "user_session=${github_cookie_user_session}; __Host-user_session_same_site=${github_cookie_user_session}" \
  -F "name=${avatar##*/}" \
  -F "size=${avatar_size}" \
  -F "content_type=image/jpeg" \
  -F "authenticity_token=$(grep -oP '[^"]*(?=" data-csrf="true" class="js-data-upload-policy-url-csrf")' <<< "${fetch}")" \
  -F "owner_type=User" \
  -F "owner_id=$(grep -oP '(?<=<meta name="octolytics-actor-id" content=")[^"]*' <<< "${fetch}")" \
  "${github_url_create}" \
)

RESPONSE "GITHUB-CREATE" "${create}"

upload=$(curl -s \
  -X POST \
  -H "Content-Type: multipart/form-data" \
  -H "github-remote-auth: $(grep -o '"header":[^}]*' <<< $create | grep -o '"GitHub-Remote-Auth":"[^"]*' | grep -o '[^"]*$')" \
  -F "authenticity_token=$(grep -o '"upload_authenticity_token":"[^"]*' <<< $create | grep -o '[^"]*$')" \
  -F "owner_type=User" \
  -F "owner_id=$(grep -oP '(?<=<meta name="octolytics-actor-id" content=")[^"]*' <<< "${fetch}")" \
  -F "size=${avatar_size}" \
  -F "content_type=image/jpeg" \
  -F "file=@${avatar}" \
  "$(grep -o '"upload_url":"[^"]*' <<< $create | grep -o '[^"]*$')" \
)

RESPONSE "GITHUB-UPLOAD" "${upload}"

fetch_avatar=$(curl -s \
  -X GET \
  -b "user_session=${github_cookie_user_session}; __Host-user_session_same_site=${github_cookie_user_session}" \
  "https://github.com/settings/avatars/$(grep -o '"id":[^,]*' <<< $upload | grep -o '[^:]*$')" \
)

RESPONSE "GITHUB-FETCH-AVATAR" "${fetch_avatar}"

save=$(curl -s \
  -X POST \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -b "user_session=${github_cookie_user_session}; __Host-user_session_same_site=${github_cookie_user_session}" \
  -d "op=save&\
  authenticity_token=$(grep -oP '(?<=<input type="hidden" name="authenticity_token" value=")[^"]*' <<< "${fetch_avatar}")&\
  cropped_x=${cropped_x}&\
  cropped_y=${cropped_y}&\
  cropped_width=${cropped_width}&\
  cropped_height=${cropped_height}" \
  "https://github.com/settings/avatars/$(grep -o '"id":[^,]*' <<< $upload | grep -o '[^:]*$')" \
)

RESPONSE "GITHUB-SAVE" "${save}"

INFO "Updated avatar in GitHub"