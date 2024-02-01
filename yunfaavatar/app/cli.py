#!/usr/bin/env python3

import logging
import click
from ..utils import config

LOGGER = logging.getLogger("yunfaavatar")


@click.group()
def group():
    pass


@group.command("enable", help="Enable the service and save to the configuration.")
@click.argument("service", type=click.STRING)
def enable(service: str):
    config.raw_enable(service)


@group.command("disable", help="Disable the service and save to the configuration.")
@click.argument("service", type=click.STRING)
def disable(service: str):
    config.raw_disable(service)


@group.command("interactive", help="yooo")
def interactive(service: str):
    config.raw_disable(service)


group()
