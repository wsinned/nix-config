{
  description = "Wsinned's NixOS Configuration";

  inputs = {
    # Nixpkgs
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    # You can access packages and modules from different nixpkgs revs
    # at the same time. Here's an working example:
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # Also see the 'unstable-packages' overlay at 'overlays/default.nix'.
    
    # Only for cosmic desktop
    nixpkgs.follows = "nixos-cosmic/nixpkgs-stable";
    nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixvim = {
        # url = "github:nix-community/nixvim/nixos-24.05";
        url = "github:nix-community/nixvim";
        inputs.nixpkgs.follows = "nixpkgs";
    };

    # TODO: Add any other flake you might need
    hardware.url = "github:nixos/nixos-hardware";

    # Shameless plug: looking for a way to nixify your themes and make
    # everything match nicely? Try nix-colors!
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { self, nixpkgs, home-manager, nixvim, nixos-cosmic, ...} @ inputs: 
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib;
    # Supported systems for your flake packages, shell, etc.
    systems = [ "aarch64-linux" "x86_64-linux" ];

    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
    pkgsFor = lib.genAttrs systems (system: import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    });
  in 
  {

    inherit lib;
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;
    templates = import ./templates;

    overlays = import ./overlays { inherit inputs outputs; };
    hydraJobs = import ./hydra.nix { inherit inputs outputs; };

    packages = forEachSystem (pkgs: import ./pkgs { inherit pkgs; });
    devShells = forEachSystem (pkgs: import ./shell.nix { inherit pkgs; });
    formatter = forEachSystem (pkgs: pkgs.nixpkgs-fmt);

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      # Main personal laptop
      dw-apollo = lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [ 
          ./hosts/dw-apollo 
        ];
      };
      # Spare laptop for experiments
      dw-dell = lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [ 
          ./hosts/dw-dell
          ];
      };
      # test laptop for experiments
      dw-hp-lt = lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [ 
          ./hosts/dw-hp-lt
          {
            nix.settings = {
              substituters = [ "https://cosmic.cachix.org/" ];
              trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
            };
          }
          nixos-cosmic.nixosModules.default
          # note including configuration here and not in teh dw-hp-lt/default.nix
          ./configuration.nix
        ];
      };
    };

 };
}
