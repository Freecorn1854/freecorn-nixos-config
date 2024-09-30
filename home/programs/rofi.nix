{pkgs, config, outputs, ...}: {
  # Enable Rofi
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    terminal = "foot";
    font = "Ubuntu 14";
  };
  home.packages = let
    # All my rofi scripts in one file
    rofiScripts = pkgs.writeScriptBin "rofiscripts" ''      
      # Lock menu
      handle_power() {
        POWER=$(echo -e "Shutdown\nReboot\nSleep\nLock\nKill" | rofi -dmenu -i -p "Power")
        case $POWER in
          Shutdown) poweroff;;
          Reboot) reboot;;
          Sleep) swaylock --sleep &;;
          Lock) swaylock &;;
          Kill) pkill -9 sway;;
        esac
      }
            
      # Check for command-line arguments
      if [ "$1" == "--power" ]; then
        handle_power
      else
        echo "Please use a valid argument."
      fi
    '';
  in with pkgs; [
    rofiScripts
    rofi-bluetooth
    bemoji
  ];
}
