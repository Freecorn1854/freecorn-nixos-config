{
  description = "Freecorns Flakey Flake";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";

    # Flatpak Support, in Nix style!
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.4.1";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Roblox for linux
    sober = {
       url = "https://sober.vinegarhq.org/sober.flatpakref";
       flake = false;
      };
    };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    nur,
    nix-flatpak,
    home-manager,
    ...
  } @inputs: let
    inherit (self) outputs;
    forAllSystems = nixpkgs.lib.genAttrs [
      "x86_64-linux"
    ];
  in {
    # Your custom packages and modifications, exported as overlays
    overlays = import ./extras/overlays.nix {inherit inputs;};

    # Variables defined so they can be accessed globally
    ws = import ./extras/workspaces.nix;
    look = import ./extras/look.nix;    

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      FreecornDesktop = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        # > Our main nixos configuration file <
        modules = [
	  inputs.nix-flatpak.nixosModules.nix-flatpak
	  ./system/fcdesktop.nix

	];
      };
    };

    # Standalone home-manager configuration
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      "freecorn@FreecornDesktop" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
	extraSpecialArgs.flake-inputs = inputs;
        modules = [
          ./home/home.nix
        ];
      };
    };
  };
}
