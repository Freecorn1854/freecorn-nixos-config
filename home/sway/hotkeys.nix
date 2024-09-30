{config, pkgs, outputs, ...}: {
  wayland.windowManager.sway = {
    config = let
      primeMod = "Mod4";
    in {
      modifier = "${primeMod}";
      keybindings = {
        "${primeMod}+Tab" = ''exec rofi -show drun'';
      };
    };
  };
}
