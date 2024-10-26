{
  description = "A Nix-flake-based Deno development environment";

  # GitHub URLs for the Nix inputs we're using
  inputs = {
    # Simply the greatest package repository on the planet
    nixpkgs.url = "github:NixOS/nixpkgs";
    # A set of helper functions for using flakes
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, rust-overlay }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [
        ];

        # System-specific nixpkgs with rust-overlay applied
        pkgs = import nixpkgs { inherit system overlays; };

        # Other utilities commonly used in Deno projects
        others = with pkgs; [ deno ];
      in {
        devShells = {
          default = pkgs.mkShell {
            # Packages included in the environment
            buildInputs = [ others ];

            # Run when the shell is started up
            shellHook = ''
              deno --version
            '';
          };
        };
      });
}
