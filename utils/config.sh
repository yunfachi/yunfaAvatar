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

show_info=true
show_response=false
show_error=true

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

# service:github
github=false
github_createurl="https://github.com/upload/policies/avatars"
github_session="xxxxxxxxxxxxxxxxxxxxxxxxxxx-xxxxxxxxxxxxxxxxxxxx"
github_auth="xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx-xxxxxxxxxxx"
github_id="xxxxxxxx"

# service:discord
discord=false
discord_uploadurl="https://discord.com/api/v9/users/@me"
discord_auth="xxxxxxxxxxxxxxxxxxxxxxxx.xxxxxx.xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
discord_properties="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

# service:steam
steam=false
steam_uploadurl="https://steamcommunity.com/actions/FileUploader"
steam_sessionid="xxxxxxxxxxxxxxxxxxxxxxxx"
steam_auth="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx.xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx.xxxxxxxxxxxxxxxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxxxx-xxxxxxxxxxxxx-xxxxxxxxxxxxxxxxxxxxx"
steam_id64="xxxxxxxxxxxxxxxxx"

# service:qnahabr
habrqna=false
habrqna_uploadurl="https://qna.habr.com/upload?profile=ss"
habrqna_fetchurl="https://qna.habr.com/my/profile"
habrqna_saveurl="https://qna.habr.com/my/save_profile"
habrqna_tostersid="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

# service:hypixel
hypixel=false
hypixel_uploadurl="https://hypixel.net/account/avatar"
hypixel_fetchurl="https://hypixel.net/rules"
hypixel_id="xxxxxxx"
hypixel_auth="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
hypixel_tfa="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
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
