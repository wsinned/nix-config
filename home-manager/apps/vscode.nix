{ pkgs, ... }:

{
	home.packages = with pkgs; [

    vscode-fhs
    # (vscode-with-extensions.override { 
    #   vscodeExtensions = with vscode-extensions; [
    #     asvetliakov.vscode-neovim
    #     rust-lang.rust-analyzer
    #     ms-python.vscode-pylance
    #     ms-python.python
    #     ms-python.debugpy
    #     charliermarsh.ruff
    #     tamasfe.even-better-toml
    #     denoland.vscode-deno
    #   ];
    # })
	];
}
