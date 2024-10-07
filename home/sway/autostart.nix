{config, pkgs, ...}: {
  # Enable Sway and write some scripts
  wayland.windowManager.sway = {
    config = {
      # Use Waybar rather than Sway's
	bars = [{command = "waybar";}];
      startup = [

# apps
        {command = "steam -silent";}
        {command = "vesktop";}
        {command = "ckb-next --background";}
       # {command = "thunderbird";}
      ];
    };
  };
}
