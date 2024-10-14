{pkgs, ...}: {
  users.users.freecorn = {
    description = "FreeCorn";
    isNormalUser = true;
    extraGroups = [ 
      "networkmanager"
      "wheel"
      "video"
      "scanner"
      "lp"
      "plugdev"
      "vboxusers"
      "libvirtd"
      "qemu-libvirtd"
      "kvm"
    ];
    uid = 1000;
    shell = pkgs.zsh;
  };
}
