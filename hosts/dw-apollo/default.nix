
{ inputs, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/core.nix
    ../../modules/desktop/niri.nix
    ../../home/wsinned
  ];

  home-manager.users.wsinned.imports = [
    ../../home/wsinned/vars.nix
  ];

  networking.hostName = "dw-apollo";

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  environment.systemPackages = [
    inputs.take-note.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  # Keep this value at the release used for this fresh installation.
  system.stateVersion = "26.05";
}
