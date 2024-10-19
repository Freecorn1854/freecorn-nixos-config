let
  secrets = import ./secrets.nix;
in {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.freecorn = {
    description = "FreeCorn";
    isNormalUser = true;
    openssh.authorizedKeys.keys = secrets.cornKeys;
    extraGroups = [ 
      "networkmanager"
      "wheel"
      "video"
      "scanner"
      "lp"
      "plugdev"
      "nginx"
      "nfsShare"
      "docker"
    ];
    uid = 1000;
  };
  users.users.nextcloud = {
      extraGroups = [ "nfsShare" ];
      isSystemUser = true;
  };

  # Define home manager programs and configs
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.freecorn = { config, pkgs, ... }: {
  #    imports = [ 
    #   ./zsh.nix
     #  ./neovim.nix 
#      ];
      # Install user programs
      home.packages = (with pkgs; [
        rustdesk-flutter anydesk vlc
      ]);

      # OBS with plugins
      programs.obs-studio = {
        enable = true;
        plugins = with pkgs.obs-studio-plugins; [
          advanced-scene-switcher obs-multi-rtmp
        ];
      };

      # Don't change this
      home.stateVersion = "24.05";
    };
  };
}
