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
    mkNixos = modules: nixpkgs.lib.nixosSystem {
      inherit modules;
      specialArgs = { inherit inputs outputs; };
    };
    
    mkHome = modules: pkgs: home-manager.lib.homeManagerConfiguration {
      inherit modules pkgs;
      extraSpecialArgs = { inherit inputs outputs; };
    };

  in rec {
    # Your custom packages and modifications, exported as overlays
    overlays = import ./extras/overlays.nix {inherit inputs;};

    # Variables defined so they can be accessed globally
    ws = import ./extras/workspaces.nix;
    look = import ./extras/look.nix;   

    # secrets for server
    secrets = import ./system/hosts/server/secrets.nix;

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      FreecornDesktop = mkNixos [
	  inputs.nix-flatpak.nixosModules.nix-flatpak
	  ./system/hosts/desktop/fcdesktop.nix
	];

      FreecornMacbook = mkNixos [
	  inputs.nix-flatpak.nixosModules.nix-flatpak
	  ./system/hosts/macbook/fcmacbook.nix
	];

      freecornserver = mkNixos [
	  inputs.nix-flatpak.nixosModules.nix-flatpak
	  ./system/hosts/server/fcserver.nix
	];
      };

    # Standalone home-manager configuration
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      "freecorn@FreecornDesktop" = mkHome [
          ./home/hosts/desktop/home.nix
          nur.nixosModules.nur
        ] nixpkgs.legacyPackages."x86_64-linux";

      "freecorn@FreecornMacbook" = mkHome [
          ./home/hosts/macbook/home.nix
          nur.nixosModules.nur
        ] nixpkgs.legacyPackages."x86_64-linux";

       "freecorn@freecornserver" = mkHome [
          ./home/hosts/server/home.nix
          nur.nixosModules.nur
        ] nixpkgs.legacyPackages."x86_64-linux";
      };
   };
}
