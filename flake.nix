{
  description = "fox32asm";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (sys:
      let pkgs = import nixpkgs { system = sys; };

      in rec {
        packages.default = pkgs.rustPlatform.buildRustPackage {
          name = "fox32asm";
          src = ./. ;
          cargoLock = { lockFile = ./Cargo.lock; };

          NIX_SEMVER = version;
          NIX_GIT_SHA_SHORT = if self ? rev then self.rev else "dirty";
        };
      }
    );
}
