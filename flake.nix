{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {nixpkgs, ...}: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
    pkgs-python = pkgs.python311Packages.override {
      overrides = self: super: {
        /*
          yunfaavatar = super.buildPythonPackage rec {
          pname = "yunfaavatar";
          version = "1.0.0";
          src = super.fetchPypi {
            inherit pname version;
            sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
          };
          buildInputs = with super; [];
        };
        */
      };
    };
  in {
    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs;
        [
          python313
          gnumake
          black
        ]
        ++ (with pkgs-python; [
          pyyaml
          aiohttp
        ]);
    };
  };
}
