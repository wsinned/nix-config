{
  description = "A Nix-flake-based Python development environment";

  # GitHub URLs for the Nix inputs we're using
  inputs = {
    # Simply the greatest package repository on the planet
    nixpkgs.url = "github:NixOS/nixpkgs";
    # A set of helper functions for using flakes
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [
        ];

        # System-specific nixpkg
        pkgs = import nixpkgs { inherit system overlays; };

        # Other utilities commonly used in Python projects
        others = with pkgs; [ 
        
          (pkgs.python312.withPackages (python-pkgs: [
            # select Python packages here
            python-pkgs.pip
            python-pkgs.setuptools
            python-pkgs.wheel
            python-pkgs.build
            python-pkgs.twine
            python-pkgs.pytest
            python-pkgs.dateutils
          ]))
          exercism
          ruff
        ];
        
      in {
        devShells = {
          default = pkgs.mkShell {
            # Packages included in the environment
            buildInputs = [ others ];

            # Run when the shell is started up
            shellHook = ''
              python --version
            '';
          };
        };
      });
}
