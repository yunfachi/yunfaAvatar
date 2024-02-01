#!/usr/bin/env python3

import logging
from .utils import config, avatar

"""
Variables
"""
LOGGER = logging.getLogger("yunfaavatar")

"""
Code
"""
class Client:
    def __init__(self, config_path: str = None, avatar_url: str = None):
        self.config = config.Config(config_path)
        self.avatar = avatar.Avatar(avatar_url)

    def set_config(self, config_path: str):
        self.config = config.Config(config_path)

    def set_avatar(self, avatar_url: str):
        self.avatar = avatar.Avatar(avatar_url)
