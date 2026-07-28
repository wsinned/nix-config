{ pkgs, ... }:

{
  programs.niri.enable = true;

  services.displayManager.gdm.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
    ];
    config.common.default = [
      "gnome"
      "gtk"
    ];
  };

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    # Niri session
    niri
    xwayland-satellite
    waybar
    mako
    swaybg
    swayidle
    swaylock
    foot
    alacritty
    kitty

    # Launchers, menus and desktop integration used by the shared dotfiles
    vicinae
    nautilus
    networkmanagerapplet
    blueman
    pavucontrol
    polkit_gnome

    # Utilities referenced by the Niri and Waybar configurations
    awww
    wallust
    yazi
    bottom
    brightnessctl
    hyprpicker
    playerctl
    libnotify
    wl-clipboard
    google-chrome
  ];

  # The tech-notes Niri config contains an Arch-specific /usr/lib command for
  # this agent. Starting it declaratively makes the session portable to NixOS.
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "GNOME PolicyKit authentication agent";
    wantedBy = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
    };
  };

  systemd.user.services.mako = {
    description = "Mako notification daemon";
    wantedBy = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.mako}/bin/mako";
      Restart = "on-failure";
    };
  };
}
