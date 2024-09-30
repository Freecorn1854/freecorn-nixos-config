{pkgs, config, outputs, ...}: {
  # Enable Rofi
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    terminal = "foot";
    font = "${outputs.look.fonts.main} 14";
    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "*" = {
        lightbg = mkLiteral "#EEE8D5";
        lightfg = mkLiteral "#586875";
        blue = mkLiteral "#268BD2";
        red = mkLiteral "#DC322F";
        background-color = mkLiteral "#00000000";
        separatorcolor = mkLiteral "#00000000";
        normal-foreground = mkLiteral "#${outputs.look.colors.text}";
        normal-background = mkLiteral "#${outputs.look.colors.dark}1A";
        urgent-foreground = mkLiteral "#${outputs.look.colors.urgent}";
        active-foreground = mkLiteral "#${outputs.look.colors.split}";
        selected-active-foreground = mkLiteral "#${outputs.look.colors.prime}";
        background = mkLiteral "#${outputs.look.colors.dark}B3";
        bordercolor = mkLiteral "#${outputs.look.colors.prime}";
        selected-normal-foreground = mkLiteral "#FFFFFF";
        selected-normal-background = mkLiteral "#${outputs.look.colors.prime}80";
        border-color = mkLiteral "#${outputs.look.colors.prime}";
        urgent-background = mkLiteral "#${outputs.look.colors.accent}26";
        active-background = mkLiteral "#${outputs.look.colors.accent}26";
        selected-active-background = mkLiteral "#${outputs.look.colors.split}54";
      };
      "#window" = {
        background-color = mkLiteral "@background";
        width = 500;
        border = mkLiteral "${outputs.look.border.string}";
        padding = 5;
      };
      "#message" = {
        border = mkLiteral "1px dash 0px 0px";
        border-color = mkLiteral "@separatorcolor";
        padding = 1;
      };
      "#textbox" = {
        text-color = mkLiteral "@normal-foreground";
      };
      "#listview" = {
        fixed-height = 0;
        border-color = mkLiteral "@separatorcolor";
        scrollbar = mkLiteral "false";
        columns = 2;
      };
      "#element" = {
        border = 0;
        padding = 1;
      };
      "#element-text" = {
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };
      "#element.normal.normal" = {
        text-color = mkLiteral "@normal-foreground";
      };
      "#element.normal.urgent" = {
        text-color = mkLiteral "@urgent-foreground";
      };
      "#element.normal.active" = {
        background-color = mkLiteral "@active-background";
        text-color = mkLiteral "@active-foreground";
      };
      "#element.selected.normal" = {
        background-color = mkLiteral "@selected-normal-background";
        text-color = mkLiteral "@selected-normal-foreground";
      };
      "#element.selected.urgent" = {
        background-color = mkLiteral "@urgent-background";
        text-color = mkLiteral "@urgent-foreground";
      };
      "#element.selected.active" = {
        background-color = mkLiteral "@selected-active-background";
        text-color = mkLiteral "@selected-active-foreground";
      };
      "#element.alternate.normal" = {
        text-color = mkLiteral "@normal-foreground";
      };
      "#element.alternate.urgent" = {
        text-color = mkLiteral "@urgent-foreground";
      };
      "#element.alternate.active" = {
        background-color = mkLiteral "@active-background";
        text-color = mkLiteral "@active-foreground";
      };
      "#mode-switcher" = {
        border = mkLiteral "2px dash 0px 0px";
        border-color = mkLiteral "@separatorcolor";
      };
      "#button.selected" = {
        background-color = mkLiteral "@selected-normal-background";
        text-color = mkLiteral "@selected-normal-foreground";
      };
      "#case-indicator" = {
        spacing = mkLiteral "0";
        text-color = mkLiteral "@normal-foreground";
      };
      "#entry" = {
        spacing = 0;
        text-color = mkLiteral "@normal-foreground";
      };
      "#prompt" = {
        spacing = 0;
        text-color = mkLiteral "@normal-foreground";
      };
      "#inputbar" = {
        spacing = 0;
        text-color = mkLiteral "@normal-foreground";
        padding = 1;
        children = map mkLiteral ["prompt" "textbox-prompt-colon" "entry"];
      };
      "#textbox-prompt-colon" = {
        expand = false;
        str = ":";
        margin = mkLiteral "0px 0.3em 0em 0em";
        text-color = mkLiteral "@normal-foreground";
      };
    };
  };
  home.packages = let
    # All my rofi scripts in one file
    rofiScripts = pkgs.writeScriptBin "rofiscripts" ''
      # Scratchpad function
      handle_scratchpads() {
        SCRATCHPADS=$(echo -e "Gotop\nMusic\nSound\nEasyEffects" | rofi -dmenu -i -p "Scratchpads")
        case $SCRATCHPADS in
          Gotop) foot -a gotop -T Gotop gotop;;
          Music) foot -a music -T Music ncmpcpp;;
          Sound) foot -a sound -T Sound pulsemixer;;
          EasyEffects) easyeffects;;
        esac
      }
      
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
      
      # Resolutions
      handle_resolutions() {
        RET=$(echo -e "Default\nWide\nGPU2" | rofi -dmenu -i -p "Resolutions")
        case $RET in
          Default) swaymsg reload ;;
          Wide) swaymsg "
            output ${outputs.displays.d1} enable pos 1680 0 mode 1680x1050@59.954Hz
            output ${outputs.displays.d2} enable pos 0 0 mode 1680x1050@59.954Hz
            output ${outputs.displays.d3} enable pos 3360 0 transform 0
          ";;
          GPU2) swaymsg "
            output ${outputs.displays.d2} enable pos 1680 0 mode 1920x1080@60Hz
            output ${outputs.displays.d3} enable pos 0 0 transform 0
          ";;
        esac
      }
      
      # Check for command-line arguments
      if [ "$1" == "--scratchpads" ]; then
        handle_scratchpads
      elif [ "$1" == "--power" ]; then
        handle_power
      elif [ "$1" == "--resolutions" ]; then
        handle_resolutions
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
