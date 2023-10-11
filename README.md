
# <p align="center">yunfaAvatar</p>

Utility for automatic centralized changing of avatar in Github, Discord, Steam, Hypixel, etc.


## Usage  
```bash
# will update your avatar in discord and steam
yunfaavatar --avatar=https://avatars.githubusercontent.com/u/73419713 \
            --github=false --steam --discord

# will crop the cat.png image according to the specified values, install it
# on the avatar in Habr Q&A, Github and Steam, and will also send a response
# from the services (useful when you set cookies or something doesn’t work for you)
yunfaavatar --avatar=cat.png --cropped_x=50 --cropped_y=50
            --cropped_width=450 --cropped_height=450
            --habrqna --github --steam --show_response=true

# in order not to write the service you need in the arguments every time, you
# can put “true” in the variable with the name of your service in the config
# ${HOME}/.config/yunfaAvatar/config.conf
# github=true
# steam=true
# discord=true
yunfaavatar --avatar=cute_cat.png
```

## Services
- Discord    
- GitHub
- Habr Q&A (habrqna)
- Hypixel
- Shikimori
- Steam
