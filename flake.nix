{
  description = "Cyfrin Updraft Flake";

  inputs = {
    nixpkgs.url      = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    flake-utils.url  = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, rust-overlay, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs {
          inherit system overlays;
        };
      in
      with pkgs;
      {
        devShells.default = mkShell {
          buildInputs = [
            # openssl
            # pkg-config
            # eza
            # fd

            (rust-bin.stable.latest.default.override {
              extensions = [ "rust-src" ];
              targets = [ "arm-unknown-linux-gnueabihf" ];
            })

            rust-analyzer
            cargo-binstall

            solc

            bun
            nodejs

            # asdf-vm
          ];

          shellHook = ''
            # alias ls=eza
            # alias find=fd
          '';
        };
      }
    );
}
