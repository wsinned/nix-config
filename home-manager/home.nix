# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix

    ./apps/oh-my-zsh.nix
    ./apps/git.nix
    ./apps/gh.nix
    ./apps/helix.nix
    ./apps/kitty.nix
    ./apps/unfree.nix

    ./apps/unstable.nix

    ./config/aliases.nix
    ./config/vars.nix

  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "wsinned";
    homeDirectory = "/home/wsinned";

    packages = with pkgs; [
      bitwarden
      brave
      maestral-gui
      firefox
      ffmpeg
      gzip
      htop
      meslo-lgs-nf
      fastfetch
      p7zip
      qpdf
      tutanota-desktop
      tree
      ulauncher
      zsh-powerlevel10k
      
      # generic devtools
      direnv
      ltex-ls

      # gaming
      steam
      # protontricks

      # python tools
      python311Full
      python311Packages.pip
      python311Packages.meson
      pipx

      #general desktop
      scribus
    ];
  };

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    extraConfig = '' 
      set number relativenumber
      set colorscheme slate
    '';
  };

  # These are needed for desktop files and font registration
  targets.genericLinux.enable = true;
  programs.bash.enable = true;
  fonts.fontconfig.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
