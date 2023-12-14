#!/usr/bin/env python3

__title__ = "yunfaavatar"
__version__ = "0.3.0"
__author__ = "yunfachi"
__description__ = "A utility for automated and centralized avatar updates"

from .client import Client

from .utils import logging
del logging
#print([v for v in globals() if not v.startswith("_")])
