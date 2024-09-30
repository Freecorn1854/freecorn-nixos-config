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

        # Switch to workspaces
        "${primeMod}+grave" = ''workspace ${outputs.ws.w0}'';
        "${primeMod}+1" = ''workspace ${outputs.ws.w1}'';
        "${primeMod}+2" = ''workspace ${outputs.ws.w2}'';
        "${primeMod}+3" = ''workspace ${outputs.ws.w3}'';
        "${primeMod}+4" = ''workspace ${outputs.ws.w4}'';
        "${primeMod}+5" = ''workspace ${outputs.ws.w5}'';
        "${primeMod}+6" = ''workspace ${outputs.ws.w6}'';
        "${primeMod}+7" = ''workspace ${outputs.ws.w7}'';
        "${primeMod}+8" = ''workspace ${outputs.ws.w8}'';
        "${primeMod}+9" = ''workspace ${outputs.ws.w9}'';

        # Switch to alternate workspaces
        "${secMod}+F1" = ''workspace ${outputs.ws.w1a}'';
        "${secMod}+F2" = ''workspace ${outputs.ws.w2a}'';
        "${secMod}+F3" = ''workspace ${outputs.ws.w3a}'';
        "${secMod}+F4" = ''workspace ${outputs.ws.w4a}'';
        "${secMod}+F5" = ''workspace ${outputs.ws.w5a}'';
        "${secMod}+F6" = ''workspace ${outputs.ws.w6a}'';
        "${secMod}+F7" = ''workspace ${outputs.ws.w7a}'';
        "${secMod}+F8" = ''workspace ${outputs.ws.w8a}'';
        "${secMod}+F9" = ''workspace ${outputs.ws.w9a}'';

        # Move window to and focus new workspace
        "${primeMod}+Shift+grave" = ''move container to workspace ${outputs.ws.w0}; workspace ${outputs.ws.w0}'';
        "${primeMod}+Shift+1" = ''move container to workspace ${outputs.ws.w1}; workspace ${outputs.ws.w1}'';
        "${primeMod}+Shift+2" = ''move container to workspace ${outputs.ws.w2}; workspace ${outputs.ws.w2}'';
        "${primeMod}+Shift+3" = ''move container to workspace ${outputs.ws.w3}; workspace ${outputs.ws.w3}'';
        "${primeMod}+Shift+4" = ''move container to workspace ${outputs.ws.w4}; workspace ${outputs.ws.w4}'';
        "${primeMod}+Shift+5" = ''move container to workspace ${outputs.ws.w5}; workspace ${outputs.ws.w5}'';
        "${primeMod}+Shift+6" = ''move container to workspace ${outputs.ws.w6}; workspace ${outputs.ws.w6}'';
        "${primeMod}+Shift+7" = ''move container to workspace ${outputs.ws.w7}; workspace ${outputs.ws.w7}'';
        "${primeMod}+Shift+8" = ''move container to workspace ${outputs.ws.w8}; workspace ${outputs.ws.w8}'';
        "${primeMod}+Shift+9" = ''move container to workspace ${outputs.ws.w9}; workspace ${outputs.ws.w9}'';

        # Move window to and focus new alternate workspace
        "${secMod}+Shift+F1" = ''move container to workspace ${outputs.ws.w1a}; workspace ${outputs.ws.w1a}'';
        "${secMod}+Shift+F2" = ''move container to workspace ${outputs.ws.w2a}; workspace ${outputs.ws.w2a}'';
        "${secMod}+Shift+F3" = ''move container to workspace ${outputs.ws.w3a}; workspace ${outputs.ws.w3a}'';
        "${secMod}+Shift+F4" = ''move container to workspace ${outputs.ws.w4a}; workspace ${outputs.ws.w4a}'';
        "${secMod}+Shift+F5" = ''move container to workspace ${outputs.ws.w5a}; workspace ${outputs.ws.w5a}'';
        "${secMod}+Shift+F6" = ''move container to workspace ${outputs.ws.w6a}; workspace ${outputs.ws.w6a}'';
        "${secMod}+Shift+F7" = ''move container to workspace ${outputs.ws.w7a}; workspace ${outputs.ws.w7a}'';
        "${secMod}+Shift+F8" = ''move container to workspace ${outputs.ws.w8a}; workspace ${outputs.ws.w8a}'';
        "${secMod}+Shift+F9" = ''move container to workspace ${outputs.ws.w9a}; workspace ${outputs.ws.w9a}'';
        

        # Screenshots
        # "Print" = ''exec swayshot --swappy'';
        # "${primeMod}+Shift+f" = ''exec swayshot --swappy'';
        # "Shift+Print" = ''exec swayshot --current'';
        # "Ctrl+Print" = ''exec swayshot --all'';
	
      };
    };
  };
}
