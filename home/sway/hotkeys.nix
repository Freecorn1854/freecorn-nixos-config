{config, pkgs, outputs, ...}: {
  wayland.windowManager.sway = {
    config = rec {
      modifier = "Mod4";
      keybinds = {
        "${modifier}+Tab" = ''exec rofi -show drun'';
      };
    };
  };
}
