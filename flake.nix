{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {nixpkgs, ...}: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
    pkgs-python = pkgs.python311Packages.override {
      overrides = self: super: {
        pillow = super.pillow.override rec {
          version = "10.0.0";
        };
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
          httpx
          pillow
        ]);
    };
  };
}
