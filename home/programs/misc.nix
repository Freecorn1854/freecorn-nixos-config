{pkgs, ...}: {
  home.packages = with pkgs; [
    firefox
    wget
    fastfetch
    vesktop
    p7zip
    steam
    vlc
    git
    alsa-utils
    unstable.blender
    unstable.sdrpp
    gparted
    pcmanfm-qt
  ];
}
