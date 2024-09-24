let
  secrets = import ./secrets.nix;
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

    imports =
    [ # extra programs, what i like to call "plugins" that are too long to be added in the main file.
      /etc/nixos/plugins/programs/neovim.nix
    ];

      # Don't change this
      home.stateVersion = "24.05";
    };
  };
}
