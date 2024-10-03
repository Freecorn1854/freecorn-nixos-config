{pkgs, ...}: {
  home.packages = with pkgs; [
    firefox
    wget
    fastfetch
    vesktop
    p7zip
    vlc
    git
    alsa-utils
    unstable.blender
    unstable.sdrpp
    gparted
    unstable.pcmanfm-qt
    imv
    telegram-desktop
  ];
}
