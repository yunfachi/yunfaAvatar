#!/usr/bin/env python3

import logging

file = "latest.log"

logging.basicConfig(
    level=logging.INFO,
    filename=file,
    filemode="a",
    format=f"%(asctime)s [%(levelname)s] %(name)s (%(filename)s).%(funcName)s(%(lineno)d) ~ %(message)s",
)

# add an empty line if the file already has a log
with open(file, "r+") as f:
    lines = f.readlines()
    if lines != [] and lines[-1] != "\n":
        f.write("\n--- new start ---\n\n")
