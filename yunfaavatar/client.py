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
    def __init__(self, config_path: str = None):
        self.config = config.Config(config_path)

    def set_config_path(self, config_path: str):
        self.config = config.Config(config_path)
