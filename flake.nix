{
  description = "fox32asm";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (sys:
      let pkgs = import nixpkgs { system = sys; };

      in rec {
        packages.fox32asm = pkgs.rustPlatform.buildRustPackage rec {
          pname = "fox32asm";
          version = "0.3.0";

          src = ./. ;
          cargoLock = { lockFile = ./Cargo.lock; };

          NIX_SEMVER = version;
          NIX_GIT_SHA_SHORT = if self ? rev then builtins.substring 0 7 self.rev else "dirty";
        };
        packages.default = packages.fox32asm;
      }
    );
}
