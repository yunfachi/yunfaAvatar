MAKEFLAGS += --silent

dev:
	@nix develop --extra-experimental-features nix-command --extra-experimental-features flakes

fmt:
	@black yunfaavatar

run:
	@python3 -m yunfaavatar $1

example:
	@python3 -m examples.everything