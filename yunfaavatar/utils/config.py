#!/usr/bin/env python3

import logging
import yaml
import pathlib

"""
Variables
"""
LOGGER = logging.getLogger("yunfaavatar")
config_example = """\
version: 0.3.0
"""

"""
Code
"""

class Config(dict):
    def __init__(self, path: str):
        super().__init__()
        self.path : pathlib.Path = pathlib.Path(path)
        self.load()
    
    def load(self):
        self.clear()
        self.update(yaml.safe_load(open_path(self.path)))
    
    def save(self):
        yaml.dump(dict(self), open_path(self.path, "w"))

def open_path(path: pathlib.Path, mode: str = "r"):
        try:
            file = path.open(mode=mode, encoding = "utf-8")
        except FileNotFoundError as e:
            path.parent.mkdir(exist_ok=True, parents=True)
            with path.open(mode="w+", encoding = "utf-8") as file:
                file.write(config_example)
            LOGGER.warning(f"Configuration file not found, a new file has been created at path {path}")
            file = path.open(mode=mode, encoding = "utf-8")
        return file
