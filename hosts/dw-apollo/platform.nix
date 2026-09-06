{ lib, pkgs, ... }:

{
  zramSwap = {
    enable = true;
    memoryPercent = 25;
  };

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
    ];
  };

  environment.sessionVariables.LIBVA_DRIVER_NAME = "iHD";

  services = {
    fstrim.enable = true;
    thermald.enable = true;
    power-profiles-daemon.enable = true;
  };
}
