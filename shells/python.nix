let
  # Pinned nixpkgs, deterministic. Last updated: 16/8/24.
  # Look up latest commit at https://github.com/NixOS/nixpkgs/tree/release-24.05
  pkgs = import (fetchTarball("https://github.com/NixOS/nixpkgs/archive/de45f50d35a46096fd57d684b819a720d9396393.tar.gz")) {

    config.allowUnfree = true;

  };
  
in pkgs.mkShell {
  buildInputs = with pkgs; [ 
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
    (vscode-with-extensions.override { 
      vscodeExtensions = with vscode-extensions; [
        asvetliakov.vscode-neovim
        ms-python.vscode-pylance
        ms-python.python
        ms-python.debugpy
        charliermarsh.ruff
        tamasfe.even-better-toml
      ];
    })
  ];
}
