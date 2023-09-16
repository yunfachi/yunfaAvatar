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

reset="\e[0m"
endl="$reset\n"

text="\e[38;5;255m"
info="\e[38;5;228m"
response="\e[38;5;81m"
error="\e[38;5;196m"
delimiter="\e[38;5;0m"

SPACE() {
  printf "\n" >&2;
}

INFO() { if [ "${show_info}" == "true" ]; then
  printf "$info[INFO]$text ${1^}$endl" >&2; fi
}

RESPONSE() { if [ "${show_response}" == "true" ]; then
  printf "$response[RESPONSE]$delimiter ${1^^} :$text %s$endl" "${2}" >&2; fi
}

ERROR() { if [ "${show_error}" == "true" ]; then
  printf "$error[ERROR]$delimiter ${1^^} :$text ${2^}$endl" >&2; fi
}