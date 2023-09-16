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

INFO "Updating avatar in Discord"

upload=$(curl -s \
  -X PATCH \
  -d "@${TEMP_DIR}/avatar.json" \
  -H "Content-Type: application/json" \
  -H "Authorization: ${discord_auth}" \
  -H "X-Super-Properties: ${discord_properties}" \
  $discord_uploadurl
)

RESPONSE "DISCORD-UPLOAD" "${upload}"

INFO "Updated avatar in Discord"