#!/usr/bin/env bash

# Download
if [[ "$avatar" =~ ^"http" ]]; then
  INFO "Downloading an avatar"
  curl -s -L $avatar -o "$TEMP_DIR/avatar.${extension}"
  avatar="$TEMP_DIR/avatar.${extension}"
elif [ -f "$avatar" ]; then
  INFO "Copying an avatar"
  cp $avatar "$TEMP_DIR/avatar.${avatar##*.}"
  avatar="$TEMP_DIR/avatar.${avatar##*.}"
else
  ERROR "${avatar}" "Could not find avatar"
  exit
fi

# Crop
if [ "0" == $((${cropped_x#-}+${cropped_y#-}+${cropped_width#-}+${cropped_height#-})) ]; then
  width=$(identify -format '%w' $avatar)
  height=$(identify -format '%h' $avatar)
  if [ "${width}" -gt "${height}" ]; then
    cropped_width=$height
    cropped_height=$height
    let cropped_x=($width-$height)/2
  elif [ "${width}" -lt "${height}" ]; then
    cropped_width=$width
    cropped_height=$width
    let cropped_y=($height-$width)/2
  fi
  if [ "0" != $((${cropped_x#-}+${cropped_y#-}+${cropped_width#-}+${cropped_height#-})) ]; then
    convert $avatar -crop "${cropped_width}x${cropped_height}+${cropped_x}+${cropped_y}" $avatar
    INFO "Automatically cropped avatar from ${width}x${height} to x:${cropped_x} y:${cropped_y} width:${cropped_width} height:${cropped_height}"
  fi
else
  convert $avatar -crop "${cropped_width}x${cropped_height}+${cropped_x}+${cropped_y}" $avatar
  INFO "Manually cropped avatar from ${width}x${height} to x:${cropped_x} y:${cropped_y} width:${cropped_width} height:${cropped_height}"
fi

# Size
avatar_size=$(wc -c < $avatar)
INFO "Avatar size is $(printf "%'.0f" $avatar_size) bytes"

# Base64
avatar_base64="data:image/png;base64,$(base64 -w 0 $avatar)"
printf "{\"avatar\":\"${avatar_base64}\"}" > $TEMP_DIR/avatar.json
INFO "Converted avatar to base64"
