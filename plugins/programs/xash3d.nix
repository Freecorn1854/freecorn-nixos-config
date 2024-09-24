{pkgs, ...}: {
  home.packages = with pkgs; [
    xash3d
    hlsdk
  ];
}
