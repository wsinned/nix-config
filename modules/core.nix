{ pkgs, ... }:

{
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;
    substituters = [
      "https://cache.nixos.org"
      "https://nixos-raspberrypi.cachix.org"
    ];

    trusted-public-keys = [
      "nixos-raspberrypi.cachix.org-1:4iMO9LXa8BqhU+Rpg6LQKiGa2lsNh/j2oiYLNOQ5sPI="
    ];
  };

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (pkgs.lib.getName pkg) [
      "google-chrome"
      "geekbench"
      "obsidian"
      "discord"
      "steam"
      "steam-unwrapped"
    ];

  networking = {
    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
    };
    firewall.enable = true;
  };

  services.resolved.enable = true;

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";
  console.keyMap = "uk";

  hardware.bluetooth.enable = true;
  services = {
    blueman.enable = true;
    printing.enable = true;
    openssh.enable = true;
    tailscale = {
      enable = true;
      openFirewall = true;
    };
  };

  systemd.services.tailscaled.serviceConfig.TimeoutStopSec = "10s";

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.wsinned = {
    isNormalUser = true;
    description = "Dennis Woodruff";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;

  environment.localBinInPath = true;

  environment.systemPackages = with pkgs; [
    bash
    geekbench
    neovim
    atuin
    starship
    duf
    btop
    pika-backup
  ];
}
