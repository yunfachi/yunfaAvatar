#!/usr/bin/env python3

import yunfaavatar

client = yunfaavatar.Client("./config.yaml", "https://icann.org/favicon.ico")

def config():
    print(client.config) # {'branch': 'stable'}
    client.config["branch"] = "unstable"
    print(client.config) # {'branch': 'unstable'}
    client.config.save()
    print(client.config) # {'branch': 'unstable'}

    client.config["foo"] = "bar"
    print(client.config) # {'branch': 'unstable', 'foo': 'bar'}
    client.config.load()
    print(client.config) # {'branch': 'unstable'}

    client.config["hello"] = "world"
    print(client.config) # {'branch': 'unstable', 'hello': 'world'}
    client.config.save()
    print(client.config) # {'branch': 'unstable', 'hello': 'world'}

    client.set_config("./example.yaml")
    print(client.config) # {'branch': 'stable'}

    client.set_config("./config.yaml")
    print(client.config) # {'branch': 'unstable', 'hello': 'world'}

def avatar():
    print("avatar1 url", client.avatar.url) # https://icann.org/favicon.ico
    print("avatar1 binary", client.avatar.binary[:10]) # b'\x00\x00\x01\x00\x02\x00\x10\x10\x00\x00'
    print("avatar1 base64", client.avatar.base64[:42]) # AAABAAIAEBAAAAEAIAAoBQAAJgAAACAgAAABACAAKB

    client.set_avatar("https://iana.org/favicon.ico")
    print("avatar2 url", client.avatar.url) # https://iana.org/favicon.ico
    print("avatar2 binary", client.avatar.binary[:10]) # b'\x00\x00\x01\x00\x03\x00\x10\x10\x00\x00'
    print("avatar2 base64", client.avatar.base64[:42]) # AAABAAMAEBAAAAEACABoBQAANgAAACAgAAABAAgAqA

if __name__ == "__main__":
    avatar()