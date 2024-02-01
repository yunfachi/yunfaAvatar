#!/usr/bin/env python3

import logging
from InquirerPy import prompt
from InquirerPy.base import Choice
from InquirerPy.separator import Separator

# from ..utils import config

LOGGER = logging.getLogger("yunfaavatar")
services = [
    "GitHub",
    "Discord",
    "Shikimori",
    "Habr",
    "Google",
    "YouTube",
    "foo",
    "bar",
    "eric",
    "kawazaki",
    "cago",
    "estiper",
]


def main():
    questions = [
        {
            "type": "checkbox",
            "message": "Services:",
            "choices": services,
            "transformer": lambda result: "%s region%s selected"
            % (len(result), "s" if len(result) > 1 else ""),
        },
    ]

    result = prompt(questions)


if __name__ == "__main__":
    main()
