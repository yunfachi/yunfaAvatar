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

INFO "Updating avatar in Steam"

upload=$(curl -s \
  -X POST \
  -H "Content-Type: multipart/form-data" \
  -b "sessionid=${steam_sessionid}; steamLoginSecure=${steam_id64}%7C%7C${steam_auth};" \
  -F "type=player_avatar_image" \
  -F "sId=${steam_id64}" \
  -F "sessionid=${steam_sessionid}" \
  -F "doSub=1" \
  -F "avatar=@${avatar}" \
  $steam_uploadurl \
)

RESPONSE "STEAM-UPLOAD" "${upload}"

INFO "Updated avatar in Steam"