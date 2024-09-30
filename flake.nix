{
  description = "Freecorns Flakey Flake";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    nur,
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

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      FreecornDesktop = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        # > Our main nixos configuration file <
        modules = [
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
        modules = [
          ./home/home.nix
        ];
      };
    };
  };
}
