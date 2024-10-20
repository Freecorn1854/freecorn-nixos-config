{pkgs, outputs, ...}: 
let
#  secrets = import ./secrets.nix;
in {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.freecorn = {
    description = "Freecorn";
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      "${outputs.secrets.cornKey1}"
      "${outputs.secrets.cornKey2}"
    ];

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
    shell = pkgs.zsh;
  };
  users.users.nextcloud = {
      extraGroups = [ "nfsShare" ];
      isSystemUser = true;
  };
}
