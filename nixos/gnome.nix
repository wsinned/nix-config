# This is your gnome configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  environment.gnome.excludePackages = (with pkgs; [
    epiphany # web browser
    gnome-calendar
    gnome-contacts
    gnome-music
    gnome-photos
    gnome-tour
    gnome-weather
    geary # email reader
  ]);

  # gnome-settings udev rules
  # Needed for some Gnome extensions
  services.udev.packages = with pkgs; [ gnome-settings-daemon ];

  environment.systemPackages = with pkgs; [
    # Gnome basics
    # Don't forget to enable them in the Extensions App
    gnomeExtensions.appindicator
    gnomeExtensions.tactile
    gnomeExtensions.just-perfection
    gnomeExtensions.blur-my-shell
    gnomeExtensions.auto-move-windows
    gnomeExtensions.hibernate-status-button
    gnomeExtensions.bluetooth-battery-meter
    gnomeExtensions.vitals
    
  ];

}
