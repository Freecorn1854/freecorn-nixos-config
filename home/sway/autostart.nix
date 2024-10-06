{config, pkgs, ...}: {
  # Enable Sway and write some scripts
  wayland.windowManager.sway = {
    config = {
      # Use Waybar rather than Sway's
	bars = [{command = "waybar";}];
      startup = [

# Foreground apps
        {command = "steam";}
        {command = "vesktop";}
        {command = "ckb-next";}
       # {command = "thunderbird";}
      ];
    };
  };
}
