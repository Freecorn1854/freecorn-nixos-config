{pkgs, ...}: {
  home.packages = with pkgs; [
        vlc
        git
        alsa-utils
        unstable.blender
        unstable.sdrpp
        gparted

  ];
}
