{pkgs, ...}: {
  home.packages = with pkgs; [
    dolphin-emu
    duckstation
    pcsx2
    unstable.lime3ds
  ];
}
