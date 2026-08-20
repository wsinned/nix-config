{
  config,
  lib,
  pkgs,
  ...
}:

let
  # The same checkout location is used on every Linux device. The files remain
  # owned by tech-notes and are linked rather than copied into the Nix store.
  dotfilesRoot = "${config.home.homeDirectory}/tech-notes/dotfiles";
  lockCommand =
    "${pkgs.procps}/bin/pgrep -x swaylock >/dev/null || ${pkgs.swaylock-effects}/bin/swaylock -f";

  managedConfigDirectories = [
    "foot"
    "mako"
    "niri"
    "nvim"
    "swaylock"
    "vicinae"
    "wallust"
    "waybar"
    "yazi"
  ];
in
{
  imports = [
    ./zed.nix
  ];

  home = {
    username = "wsinned";
    homeDirectory = "/home/wsinned";
    stateVersion = "26.05";

    packages = with pkgs; [
      fastfetch
      ripgrep
      fd
    ];

    file =
      lib.genAttrs (map (name: ".config/${name}") managedConfigDirectories) (
        target:
        let
          name = lib.removePrefix ".config/" target;
        in
        {
          source = config.lib.file.mkOutOfStoreSymlink "${dotfilesRoot}/.config/${name}";
          force = true;
        }
      )
      // {
        ".config/scripts" = {
          source = config.lib.file.mkOutOfStoreSymlink "${dotfilesRoot}/scripts";
          force = true;
        };

        # Compatibility path used by the current shared Niri startup command.
        "Pictures/Wallpapers/Everforest/Dark/2014-05-30-115759_14712752368_o.jpg" = {
          source = config.lib.file.mkOutOfStoreSymlink "${dotfilesRoot}/wallpapers/Everforest/Dark/a-path-in-a-forest.png";
          force = true;
        };
      };
  };

  programs = {
    home-manager.enable = true;
    fish.enable = true;
    gh = {
      enable = true;
      gitCredentialHelper.enable = false;
    };

    git = {
      enable = true;
      settings = {
      credential."https://github.com".helper = "!gh auth git-credential";
      credential."https://gist.github.com".helper = "!gh auth git-credential";
      };
    };
  };

  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 300;
        command = lockCommand;
      }
      {
        timeout = 600;
        command = "${pkgs.niri}/bin/niri msg action power-off-monitors";
        resumeCommand = "${pkgs.niri}/bin/niri msg action power-on-monitors";
      }
    ];
    events = {
      "before-sleep" = lockCommand;
      lock = lockCommand;
    };
  };
}
