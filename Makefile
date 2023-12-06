MAKEFLAGS += --silent

dev:
	@nix develop --extra-experimental-features nix-command --extra-experimental-features flakes

run:
	@python3 -m yunfaavatar