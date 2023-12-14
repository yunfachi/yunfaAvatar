#!/usr/bin/env python3

import logging
from .utils import config

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
