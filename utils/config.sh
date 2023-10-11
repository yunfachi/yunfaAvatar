#!/usr/bin/env bash

read -rd '' config <<'EOF'
# ------------------------------------------- #
#                 yunfaAvatar                 #
# You can specify each value below as an      #
# option by its name. You can remove services #
# you don`t need from the config. To update   #
# the avatar in the service by default, set   #
# true in the variable with the name of the   #
# service.                                    #
#                                             #
#   https://github.com/yunfachi/yunfaavatar   #
# ------------------------------------------- #

show_info=true # statuses about avatar updates, avatar cropping, etc.
show_response=false # response from the server. not recommended due to large responses
show_error=true # for example a broken cookie

# -------------------------------------------- #
# Avatar Avatar Avatar Avatar Avatar Avatar Av #
# -------------------------------------------- #

# link or file
avatar="https://cataas.com/cat/cute"

# required if you use the url to download the avatar
# $TEMP_DIR/avatar.${extension}
extension="jpg"

# crop avatar using these variables
# if it is still zero, then the avatar will be automatically cropped in the center
cropped_x=0
cropped_y=0
cropped_width=0
cropped_height=0

# -------------------------------------------- #
# Services Services Services Services Services #
# -------------------------------------------- #

# service:discord
discord=false
discord_header_Authorization=""
discord_header_X-Super-Properties="eyJvcyI6IkxpbnV4IiwiYnJvd3NlciI6IkZpcmVmb3giLCJkZXZpY2UiOiIiLCJzeXN0ZW1fbG9jYWxlIjoiZW4tVVMiLCJicm93c2VyX3VzZXJfYWdlbnQiOiJNb3ppbGxhLzUuMCAoWDExOyBMaW51eCB4ODZfNjQ7IHJ2OjEwOS4wKSBHZWNrby8yMDEwMDEwMSBGaXJlZm94LzExNy4wIiwiYnJvd3Nlcl92ZXJzaW9uIjoiMTE3LjAiLCJvc192ZXJzaW9uIjoiIiwicmVmZXJyZXIiOiJodHRwczovL3d3dy5nb29nbGUuY29tLyIsInJlZmVycmluZ19kb21haW4iOiJ3d3cuZ29vZ2xlLmNvbSIsInNlYXJjaF9lbmdpbmUiOiJnb29nbGUiLCJyZWZlcnJlcl9jdXJyZW50IjoiIiwicmVmZXJyaW5nX2RvbWFpbl9jdXJyZW50IjoiIiwicmVsZWFzZV9jaGFubmVsIjoic3RhYmxlIiwiY2xpZW50X2J1aWxkX251bWJlciI6MjI4NjcyLCJjbGllbnRfZXZlbnRfc291cmNlIjpudWxsfQ=="
discord_url_upload="https://discord.com/api/v9/users/@me"

# service:github
github=false
github_cookie_user_session=""
github_url_fetch="https://github.com/about"
github_url_create="https://github.com/upload/policies/avatars"

# service:habrqna
habrqna=false
habrqna_cookie_toster_sid=""
habrqna_url_upload="https://qna.habr.com/upload?profile=ss"
habrqna_url_fetch="https://qna.habr.com/my/profile"
habrqna_url_save="https://qna.habr.com/my/save_profile"

# service:hypixel
hypixel=false
hypixel_cookie_xfNew_user=""
hypixel_cookie_xfNew_tfa_trust=""
hypixel_url_fetch="https://github.com/settings/profile"
hypixel_url_upload="https://hypixel.net/account/avatar"

# service:shikimori
shikimori=false
shikimori_cookie_kawai_session=""
shikimori_url_fetch="https://shikimori.one/for_right_holders"

# service:steam
steam=false
steam_cookie_sessionid=""
steam_cookie_steamLoginSecure=""
steam_url_upload="https://steamcommunity.com/actions/FileUploader"
EOF

# Github : https://github.com/dylanaraps/neofetch/blob/master/neofetch#L4775
get_user_config() {
    # --config_file /path/to/config.conf
    if [[ -f "$config_file" ]]; then
        source "$config_file"
        INFO "Loaded the config (${config_file})"
        return

    elif [[ -f "${XDG_CONFIG_HOME}/yunfaAvatar/config.conf" ]]; then
        source "${XDG_CONFIG_HOME}/yunfaAvatar/config.conf"
        INFO "Loaded the config (${XDG_CONFIG_HOME}/yunfaAvatar/config.conf)"

    elif [[ -f "${XDG_CONFIG_HOME}/yunfaAvatar/config" ]]; then
        source "${XDG_CONFIG_HOME}/yunfaAvatar/config"
        INFO "Loaded the config (${XDG_CONFIG_HOME}/yunfaAvatar/config)"

    elif [[ -z "$no_config" ]]; then
        config_file="${XDG_CONFIG_HOME}/yunfaAvatar/config.conf"

        # The config file doesn't exist, create it.
        mkdir -p "${XDG_CONFIG_HOME}/yunfaAvatar/"
        printf '%s\n' "$config" > "$config_file"

        get_user_config
    fi
}

get_user_config
SPACE
