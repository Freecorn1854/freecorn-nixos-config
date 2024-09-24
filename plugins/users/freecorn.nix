let
  Plugins = "/etc/nixos/plugins";
in {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.freecorn = {
    isNormalUser = true;
    description = "Freecorn";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Define home manager programs and configs
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.freecorn = { config, pkgs, ... }: {
      # Install user programs
      home.packages = (with pkgs; [
        vlc git
      ]);

      # extra programs, what i like to call "plugins" that are too long to be added in the main file.
      imports = [
        "${Plugins}"/programs/neovim.nix
        "${Plugins}"/programs/minecraft.nix
      ];

      # Don't change this
      home.stateVersion = "24.05";
    };
  };
}
