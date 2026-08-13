{ ... }:

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

  networking.hostName = "dw-dell-01";

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Keep this value at the release used for this fresh installation.
  system.stateVersion = "26.05";
}
