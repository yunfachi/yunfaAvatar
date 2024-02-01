#!/usr/bin/env python3

import logging
import httpx
import pathlib
from urllib.parse import urlparse
import base64
import asyncio
from PIL import Image
from io import BytesIO

"""
Variables
"""
LOGGER = logging.getLogger("yunfaavatar")

"""
Code
"""

class Avatar():
    def __init__(self, url: str, auto_crop : bool = True):
        self.url = url
        self.auto_crop = auto_crop
        self.update()

    def update(self):
        response = httpx.get(self.url)

        self.binary = crop(response.content)
        self.base64 = str(base64.b64encode(self.binary).decode("utf-8"))



    def crop(self, content, x : int = 0, y : int = 0,
                            width : int = 0, height : int = 0):
        pass