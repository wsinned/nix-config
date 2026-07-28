{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/core.nix
    ../../modules/desktop/niri.nix
    ../../home/wsinned
  ];

  networking.hostName = "dw-dell";

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Keep this value at the release used for this fresh installation.
  system.stateVersion = "26.05";
}
