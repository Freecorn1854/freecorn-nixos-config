{pkgs, ...}: {
  home.packages = with pkgs; [
    # Web Broswser
    firefox
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
    unstable.pcmanfm-qt
    shotcut
    # Passwords
    keepass
  ];
}
