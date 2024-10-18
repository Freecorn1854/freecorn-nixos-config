{pkgs, ...}: {
  users.users.freecorn = {
    description = "Freecorn";
    isNormalUser = true;
    extraGroups = [ 
      "networkmanager"
      "wheel"
      "video"
      "scanner"
      "lp"
      "plugdev"
    ];
    uid = 1000;
    shell = pkgs.zsh;
  };
}
