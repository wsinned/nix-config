{ pkgs, inputs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../../nixos/configuration.nix
  ];

  # Bootloader.
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

  networking.hostName = "dw-dell"; # Define your hostname.
}
