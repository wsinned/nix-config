{ pkgs, inputs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./configuration.nix
  ];

  # Bootloader.
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

  networking.hostName = "dw-hp-lt"; # Define your hostname.
}
