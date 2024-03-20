{ pkgs, inputs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../../nixos/configuration.nix
  ];

  # Bootloader.
  boot = {
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    boot.initrd.luks.devices."luks-5ed9eb46-4414-4e23-a1db-626cc28aeb7f".device = "/dev/disk/by-uuid/5ed9eb46-4414-4e23-a1db-626cc28aeb7f";
  };

  networking.hostName = "dw-apollo"; # Define your hostname.
}
