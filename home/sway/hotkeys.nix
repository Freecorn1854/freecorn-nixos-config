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

        # Screenshots
        # "Print" = ''exec swayshot --swappy'';
        # "${primeMod}+Shift+f" = ''exec swayshot --swappy'';
        # "Shift+Print" = ''exec swayshot --current'';
        # "Ctrl+Print" = ''exec swayshot --all'';
	
      };
    };
  };
}
