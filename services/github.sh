#!/usr/bin/env bash 

# All Rights Reserved
# 
# Copyright (c) 2023 yunfachi
# 
# Created by yunfachi
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

INFO "Updating avatar in GitHub"

create=$(curl -s \
  -X POST \
  -H "Content-Type: multipart/form-data" \
  -b "user_session=${github_session}; __Host-user_session_same_site=${github_session}" \
  -F "name=${avatar##*/}" \
  -F "size=${avatar_size}" \
  -F "content_type=image/jpeg" \
  -F "authenticity_token=${github_auth}" \
  -F "owner_type=User" \
  -F "owner_id=${github_id}" \
  $github_createurl \
)

RESPONSE "GITHUB-CREATE" "${create}"

upload=$(curl -s \
  -X POST \
  -H "Content-Type: multipart/form-data" \
  -H "github-remote-auth: $(grep -o '"header":[^}]*' <<< $create | grep -o '"GitHub-Remote-Auth":"[^"]*' | grep -o '[^"]*$')" \
  -F "authenticity_token=$(grep -o '"upload_authenticity_token":"[^"]*' <<< $create | grep -o '[^"]*$')" \
  -F "owner_type=User" \
  -F "owner_id=${github_id}" \
  -F "size=${avatar_size}" \
  -F "content_type=image/jpeg" \
  -F "file=@${avatar}" \
  $(grep -o '"upload_url":"[^"]*' <<< $create | grep -o '[^"]*$') \
)

RESPONSE "GITHUB-UPLOAD" "${upload}"

fetch=$(curl -s \
  -X GET \
  -b "user_session=${github_session}; __Host-user_session_same_site=${github_session}" \
  "https://github.com/settings/avatars/$(grep -o '"id":[^,]*' <<< $upload | grep -o '[^:]*$')" \
)

RESPONSE "GITHUB-FETCH" "${fetch}"

save=$(curl -s \
  -X POST \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -b "user_session=${github_session}; __Host-user_session_same_site=${github_session}" \
  -d "op=save&\
  authenticity_token=$(sed -n '/token/s/.*name="authenticity_token"\s\+value="\([^"]\+\).*/\1/p' <<< $fetch)&\
  cropped_x=0&\
  cropped_y=0&\
  cropped_width=${cropped_width}&\
  cropped_height=${cropped_height}" \
  "https://github.com/settings/avatars/$(grep -o '"id":[^,]*' <<< $upload | grep -o '[^:]*$')" \
)

RESPONSE "GITHUB-SAVE" "${save}"

INFO "Updated avatar in GitHub"