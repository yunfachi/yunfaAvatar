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

###########################################
# Config Config Config Config Config Conf #
###########################################

source ./yunfaAvatar.conf

optspec=":hv-:"
while getopts "$optspec" optchar; do
  case "${optchar}" in
    -)
      case "${OPTARG}" in
        *)
          val=${OPTARG#*=}
          opt=${OPTARG%=$val}
          eval ${opt}=${val}
          ;;
      esac;;
    *)
      if [ "$OPTERR" != 1 ] || [ "${optspec:0:1}" = ":" ]; then
          echo "Non-option argument: '-${OPTARG}'" >&2
      fi
      ;;
  esac
done

###########################################
# Functions Functions Functions Functions #
###########################################

# StackOverflow : https://stackoverflow.com/a/25268449
min() {
  printf "%s\n" "${@:2}" | sort "$1" | head -n1
}
max() {
  min ${1}r ${@:2}
}

###########################################
# Avatar Avatar Avatar Avatar Avatar Avat #
###########################################

# Download
if [[ "$avatar" =~ ^"http" ]]; then
  printf "INFO: Downloading an avatar \n"
  curl -s -L $avatar -o "/tmp/avatar.${extension}"
  avatar="/tmp/avatar.${extension}"
elif [ -f "$avatar" ]; then
  printf "INFO: Found an avatar \n"
  cp $avatar "/tmp/${avatar##*/}"
  avatar="/tmp/${avatar##*/}"
else
  printf "INFO: Couldn't find avatar \n"
  exit
fi

# Crop
if [ "0" == $((${cropped_x#-}+${cropped_y#-}+${cropped_width#-}+${cropped_height#-})) ]; then
  width=$(identify -format '%w' $avatar)
  height=$(identify -format '%h' $avatar)
  cropped_width="$(min -g $width $height)"
  cropped_height=$cropped_width
  if [ $width -gt $height ]; then
    let cropped_x=($width-$height)/2
  elif [ $width -lt $height ]; then
    let cropped_y=($height-$width)/2
  fi
  convert $avatar -crop "${cropped_width}x${cropped_height}+${cropped_x}+${cropped_y}" $avatar

  printf "INFO: Automatically cropped avatar from ${width}x${height} to x:${cropped_x} y:${cropped_y} width:${cropped_width} height:${cropped_height} \n"
else
  convert $avatar -crop "${cropped_width}x${cropped_height}+${cropped_x}+${cropped_y}" $avatar

  printf "INFO: Manually cropped avatar from ${width}x${height} to x:${cropped_x} y:${cropped_y} width:${cropped_width} height:${cropped_height} \n"
fi
# Size
avatar_size=$(wc -c < $avatar)
printf "INFO: Avatar size is $avatar_size bytes \n"

# Base64
avatar_base64="data:image/png;base64,$(base64 -w 0 $avatar)"
echo "{\"avatar\":\"${avatar_base64}\"}" > /tmp/avatar.json

printf "INFO: Converted avatar to base64 \n\n"

###########################################
# Update Update Update Update Update Upda #
###########################################

update_steam() {
  printf "INFO: Updating Steam \n"
  
  output=$(curl -s \
    -H "Content-Type: multipart/form-data" \
    -b "sessionid=${steam_sessionid}; steamLoginSecure=${steam_id64}%7C%7C${steam_auth};" \
    -F "type=player_avatar_image" \
    -F "sId=${steam_id64}" \
    -F "sessionid=${steam_sessionid}" \
    -F "doSub=1" \
    -F "avatar=@${avatar}" \
    $steam_url \
  )

  if $debug; then
    echo "STEAM: ${output}"
  fi
}

update_hypixel() {
  printf "INFO: Updating Hypixel \n"
  hypixel_fetch=$(curl -s \
    -b "xfNew_tfa_trust=${hypixel_tfa}; xfNew_user=${hypixel_id}%2${hypixel_auth}" \
    -c - \
    $hypixel_fetchurl \
  )

  output=$(curl -s \
    -H "Content-Type: multipart/form-data" \
    -b <(echo "$(sed -e '0,/^<\/html>$/d' -e '/^$/d' <<< $hypixel_fetch)") \
    -F "_xfToken=$(grep -o 'data-csrf="[^"]*' <<< $hypixel_fetch | grep -o '[^"]*$')" \
    -F "avatar_crop_x=0" \
    -F "avatar_crop_y=0" \
    -F "use_custom=1" \
    -F "upload=@${avatar}" \
    -F "_xfToken=$(grep -o 'data-csrf="[^"]*' <<< $hypixel_fetch | grep -o '[^"]*$')" \
    -F "_xfResponseType=json" \
    $hypixel_url \
  )
  if $debug; then
    echo "HYPIXEL: ${output}"
  fi
}

update_discord() {
  printf "INFO: Updating Discord \n"

  output=$(curl -s \
    -X PATCH \
    -d @/tmp/avatar.json \
    -H "Content-Type: application/json" \
    -H "Authorization: ${discord_auth}" \
    -H "X-Super-Properties: ${discord_properties}" \
    $discord_url
  )

  if $debug; then
    echo "DISCORD: ${output}"
  fi
}

update_github() {
  printf "INFO: Updating Github \n"

  output1=$(curl -s \
    -H "Content-Type: multipart/form-data" \
    -b "user_session=${github_session}; __Host-user_session_same_site=${github_session}" \
    -F "name=${avatar##*/}" \
    -F "size=${avatar_size}" \
    -F "content_type=image/jpeg" \
    -F "authenticity_token=${github_auth}" \
    -F "owner_type=User" \
    -F "owner_id=${github_id}" \
    $github_url \
  )

  output2=$(curl -s \
    -H "Content-Type: multipart/form-data" \
    -H "github-remote-auth: $(grep -o '"header":[^}]*' <<< $output1 | grep -o '"GitHub-Remote-Auth":"[^"]*' | grep -o '[^"]*$')" \
    -F "authenticity_token=$(grep -o '"upload_authenticity_token":"[^"]*' <<< $output1 | grep -o '[^"]*$')" \
    -F "owner_type=User" \
    -F "owner_id=${github_id}" \
    -F "size=${avatar_size}" \
    -F "content_type=image/jpeg" \
    -F "file=@${avatar}" \
    $(grep -o '"upload_url":"[^"]*' <<< $output1 | grep -o '[^"]*$') \
  )

  output3=$(curl -s \
    -X GET \
    -b "user_session=${github_session}; __Host-user_session_same_site=${github_session}" \
    "https://github.com/settings/avatars/$(grep -o '"id":[^,]*' <<< $output2 | grep -o '[^:]*$')" \
  )

  output4=$(curl -s \
    -X POST \
    -H "Content-Type: application/x-www-form-urlencoded" \
    -b "user_session=${github_session}; __Host-user_session_same_site=${github_session}" \
    -d "op=save&\
    authenticity_token=$(sed -n '/token/s/.*name="authenticity_token"\s\+value="\([^"]\+\).*/\1/p' <<< $output3)&\
    cropped_x=0&\
    cropped_y=0&\
    cropped_width=${cropped_width}&\
    cropped_height=${cropped_height}" \
    "https://github.com/settings/avatars/$(grep -o '"id":[^,]*' <<< $output2 | grep -o '[^:]*$')" \
  )

  if $debug; then
    echo "GITHUB-1: $output1"
    echo "GITHUB-2: $output2"
    echo "GITHUB-3: $output3"
    echo "GITHUB-4: $output4"
  fi
}

###########################################
# Main Main Main Main Main Main Main Main #
###########################################

if $github; then update_github; fi
if $discord; then update_discord; fi
if $steam; then update_steam; fi
if $hypixel; then update_hypixel; fi

###########################################
# Exit Exit Exit Exit Exit Exit Exit Exit #
###########################################

#rm -rf $avatar
printf "\nINFO: Finished"
