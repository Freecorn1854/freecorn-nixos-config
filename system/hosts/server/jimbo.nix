{pkgs, ...}: let
  secrets = import ./secrets.nix;
in {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jimbo = {
    description = "Jimbo";
    isNormalUser = true;
    openssh.authorizedKeys.keys = secrets.jimKeys;
    extraGroups = [ 
      "networkmanager"
      "wheel"
      "nginx"
      "nfsShare"
    ];
    shell = pkgs.zsh;
  };

  # Enable ZSH
  programs.zsh.enable = true;
}
