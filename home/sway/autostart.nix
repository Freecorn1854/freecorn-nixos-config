{config, pkgs, ...}: {
  # Enable Sway and write some scripts
  wayland.windowManager.sway = {
    config = {
      # Use Waybar rather than Sway's

      startup = [

# Foreground apps
        {command = "steam";}
        {command = "vesktop";}
       # {command = "element-desktop";}
       # {command = "thunderbird";}
      ];
    };
  };
}
