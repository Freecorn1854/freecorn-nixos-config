{pkgs, ...}: {
  home.packages = with pkgs; [
    # Web Broswser
    # will be handled by import
    #CLI Tools
    wget
    fastfetch
    p7zip
    git
    alsa-utils
    imv
    # Messaging
    vesktop
    telegram-desktop
    # Useful programs/tools
    vlc
    unstable.blender
    unstable.sdrpp
    gparted
    pcmanfm-qt
    shotcut
    # Passwords
    keepass
    # DVDs
    unstable.dvdstyler
  ];
}
