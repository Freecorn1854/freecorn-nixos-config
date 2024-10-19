let
#  secrets = import ./secrets.nix;
in {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.freecorn = {
    description = "FreeCorn";
    isNormalUser = true;
#    openssh.authorizedKeys.keys = secrets.cornKeys;
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
}
