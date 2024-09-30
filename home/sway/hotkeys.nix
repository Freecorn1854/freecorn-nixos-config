{config, pkgs, outputs, ...}: {
  wayland.windowManager.sway = let
    primeMod = "Mod4";
  in {
    config = {
      modifier = "${primeMod}";
      keybinds = {
        "${primeMod}+Tab" = ''exec rofi -show drun'';
      };
    };
  };
}
