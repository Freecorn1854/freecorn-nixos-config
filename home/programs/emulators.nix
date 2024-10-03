{pkgs, ...}: {
  home.packages = with pkgs; [
    unstable.dolphin-emu
    duckstation
    pcsx2
    unstable.lime3ds
  ];
}
