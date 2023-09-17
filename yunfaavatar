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

XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-${HOME}/.config}
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
TEMP_DIR=$(mktemp -d)

source $SCRIPT_DIR/utils/logger.sh
source $SCRIPT_DIR/utils/config.sh
source $SCRIPT_DIR/utils/options.sh
source $SCRIPT_DIR/utils/avatar.sh

for service in $SCRIPT_DIR/services/*.sh; do
  name=$(basename $service .sh)
  value=$(eval echo \$$name)
  if [[ $value == "true" || $value == $name ]]; then
    SPACE
    source $service
  fi
done

rm -rf $TEMP_DIR
SPACE
INFO "Finished"