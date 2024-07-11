{ inputs, pkgs, ... }:

{

  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    # colorschemes.everforest.enable = true;

    plugins.neo-tree = {
      enable = true;
      enableGitStatus = true;
    };

    plugins.lazygit.enable = true;
  };

  # programs.neovim = {
  #   enable = true;
  #   viAlias = true;
  #   vimAlias = true;
  #   extraConfig = '' 
  #     set number relativenumber
  #     colorscheme slate
  #   '';
  #   plugins = with pkgs.vimPlugins; [
  #     neo-tree-nvim # File-browser
  #     lazygit-nvim
  #   ];
  # };
}