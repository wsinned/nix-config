{ inputs, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./platform.nix
    ../../modules/core.nix
    ../../modules/desktop/niri.nix
    ../../modules/gaming.nix
    ../../modules/dev.nix
    ../../home/wsinned
  ];

  programs.ydotool.enable = true;
  users.users.wsinned.extraGroups = [ "ydotool" ];

  networking.hostName = "dw-apollo";

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  environment.systemPackages = [
    inputs.take-note.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.autonumlock.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  # Keep this value at the release used for this fresh installation.
  system.stateVersion = "26.05";
}
