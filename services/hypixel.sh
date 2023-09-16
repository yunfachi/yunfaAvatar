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