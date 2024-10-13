# Declare custom nix registries that are not in https://github.com/NixOS/flake-registry/blob/master/flake-registry.json

{config, ...}: {

  nix.registry.flakes.from = {
      id = "nix-flatpak";
      type = "indirect";
  };

  nix.registry.flakes.to = {
      owner = "gmodena";
      ref = "v0.4.1";
      repo = "nix-flatpak";
      type = "github";
  };
}
