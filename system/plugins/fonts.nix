{config, pkgs, ...}: {
# Adds Microsoft Fonts :3
fonts.packages = with pkgs; [
    corefonts
    vistafonts
    nerdfonts
  ];
}
