# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports =
    [ 
      # <home-manager/nixos>
      # Import home-manager's NixOS module
      inputs.home-manager.nixosModules.home-manager
    ];

  # Enable the Flakes feature and the accompanying new nix command-line tool
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # enable avahi dns
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    ipv4 = true;
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };
  };


  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "gb";
    xkb.variant = "";
  };

  services.libinput.touchpad.naturalScrolling = true;
  services.libinput.mouse.naturalScrolling = true;

  # Configure console keymap
  console.keyMap = "uk";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Flatpak
  services.flatpak.enable = true;

  # Update policy
  system.autoUpgrade.enable = false;
  system.autoUpgrade.allowReboot = false;

  # Power management
  services.tlp = {
    enable = false;
    settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
    };
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.wsinned = {
    isNormalUser = true;
    home = "/home/wsinned";
    shell = pkgs.zsh;
    description = "Dennis Woodruff";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
      bitwarden
      vscode
    ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      # Import your home-manager configuration
      wsinned = import ../home-manager/home.nix;
    };
  };

  # Ensure zsh is enabled to be used as default shell for wsinned
  programs.zsh.enable = true;

  # Ensure we have a default java
  programs.java.enable = true;

  # allow running unpatched dynamic binaries on NixOS
  # Needed to build Native Aot compiled programs in dotnet core
  # https://nixos.wiki/wiki/DotNET
  programs.nix-ld.enable = true;

  # enable steam
  programs.steam.enable = true;
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # ensure local bin is avaliable in path
  environment.localBinInPath = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
    curl
    wget
    git
    helix
    zsh
    mc
    duf
    nvd # Nix/NixOS package version diff tool
    universal-ctags
    intel-gpu-tools

  ];

  systemd.user.services.maestral = {
    enable = false;
    description = "Maestral daemon";
    wantedBy = [ "default.target" ];
    script = "${pkgs.maestral}/bin/maestral start -f";
    preStop = "${pkgs.maestral}/bin/maestral stop";
    onFailure = [ "send-failure-email@%n.service" ];

    unitConfig.ConditionUser = "!@system";

    serviceConfig = {
      Type = "notify";
      NotifyAccess = "all";
      WatchdogSec = "30s";
      PrivateTmp = true;
      ProtectSystem = "full";
      Restart = "always";
    };
  };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
