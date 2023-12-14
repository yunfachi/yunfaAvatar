#!/usr/bin/env python3

import yunfaavatar

client = yunfaavatar.Client("./config.yaml") # {'branch': 'stable'}

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