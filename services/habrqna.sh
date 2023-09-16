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

INFO "Updating avatar in Habr Q&A"

upload=$(curl -s \
  -X POST \
  -H "Content-Type: multipart/form-data" \
  -b "toster_sid=${habrqna_tostersid}" \
  -F "files=@${avatar}" \
  $habrqna_uploadurl \
)

RESPONSE "HABRQNA-UPLOAD" "${upload}"

fetch=$(curl -s \
  -X GET \
  -b "toster_sid=${habrqna_tostersid}" \
  $habrqna_fetchurl \
)

RESPONSE "HABRQNA-FETCH" "${fetch}"

save=$(curl -s \
  -X POST \
  -H "Referer: https://qna.habr.com/my/profile" \
  -b "toster_sid=${habrqna_tostersid}" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -H "x-form-token: $(sed -n '/token/s/.*action="my\/save_profile"\s\method="post"\s\+data-token="\([^"]\+\).*/\1/p' <<< $fetch)" \
  -d "avatar_url=$(sed -E 's/\\//g
               s/.*"url":"?([^,"]*)"?.*/\1/' <<< $upload)&\
  avatar=upload&\
  firstname=&\
  lastname=&\
  short_about=&\
  about=&\
  contacts%5B0%5D%5Bprovider%5D=social_github&\
  contacts%5B0%5D%5Bvalue%5D=https%3A%2F%2Fgithub.com%2Fyunfachi&\
  place%5Bcountry%5D=0" \
  $habrqna_saveurl \
)

RESPONSE "HABRQNA-SAVE" "${save}"

INFO "Updated avatar in Habr Q&A"