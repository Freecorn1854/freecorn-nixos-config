{config, pkgs, outputs, ...}: {
  wayland.windowManager.sway = {
    config = let
      primeMod = "Mod4";
    in {
      modifier = "${primeMod}";
      keybindings = {
        "${primeMod}+Tab" = ''exec rofi -show drun'';
	"${primeMod}+Shift+q" = ''kill'';
	"${primeMod}+Return" = ''exec foot'';
	"${primeMod}+s" = ''exec rofi -show run -p Command'';
        "${primeMod}+x" = ''exec rofiscripts --power'';
      };
    };
  };
}
