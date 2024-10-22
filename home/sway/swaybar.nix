{pkgs, outputs, ...}: {
  programs.waybar = let
    swayWorkspacesModule = {
      format = "{name}";
      enable-bar-scroll = true;
      warp-on-scroll = false;
      disable-scroll-wraparound = true;
    };

    swayWindowsModule = {
      icon = true;
      icon-size = 15;
      all-outputs = true;
      tooltip = false;
      rewrite = {
        "(.*) — LibreWolf" = "   $1";
        "LibreWolf" = "   Firefox";
        "(.*) - LibreWolf — Firefox" = "󰗃   $1";
      };
    };

    pulseModule = {
      format = "{icon}  {volume}%";
      format-bluetooth = "{icon} {volume}%";
      format-muted = " muted";
      format-icons = {
        headphone = "󰋋 ";
        headset = "󰋋 ";
        default = [" " " "];
      };
      on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
      on-click-middle = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 100%";
      on-click-right = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 60%";
      ignored-sinks = ["Easy Effects Sink" "USB FS AUDIO Analog Stereo"];
    };

    # CPU, Ram and Vram
    cpuModule = {
      format = "  {usage}%";
      interval = 3;
    };
    ramModule = {
      format = "  {used}G";
      tooltip = false;
    };
    vramModule = {
      exec = pkgs.writeScript "vramScript" ''
        # Don't run the script if running on integrated graphics
        if lspci -k | grep "Kernel driver in use: nvidia" &> /dev/null || lspci -k | grep "Kernel driver in use: amdgpu" &> /dev/null; then

          # Run the nvidia-smi command and capture the VRAM usage and GPU utilization output
          if lspci -k | grep "Kernel driver in use: nvidia" &> /dev/null; then
            vram_usage_mb=$(nvidia-smi --query-gpu=memory.used --format=csv,noheader,nounits)
            temperature=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits)

          # Check the drm memory if an AMD GPU is present
          elif lspci -k | grep "Kernel driver in use: amdgpu" &> /dev/null; then
            vram_usage_mb=$(echo "$(cat /sys/class/drm/card0/device/mem_info_vram_used || cat /sys/class/drm/card1/device/mem_info_vram_used) / 1024 / 1024" | bc)
            temperature=$(sensors | grep 'edge' | awk '{print $2}' | sed 's/[^0-9.-]//g')
          fi

          # Check if VRAM usage is under 1GB
          if [ $vram_usage_mb -lt 1024 ]; then
            vram_usage_display="$(echo $vram_usage_mb)M"
          else
            # Convert MB to GiB
            vram_usage_gib=$(bc <<< "scale=2; $vram_usage_mb / 1024")
            vram_usage_display="$(echo $vram_usage_gib)G"
          fi

          # Print the VRAM usage in MB or GiB, and include GPU utilization and temperature
          echo "{\"text\":\"󰢮  $(echo $vram_usage_display)\",\"tooltip\":\"$(echo $temperature)°C\"}"
        else
          :
        fi
      '';
      format = "{}";
      return-type = "json";
      interval = 3;
    };

    # Clocks
    longClockModule = {
      exec = pkgs.writeScript "longClock" ''
        # Long clock format, with a numeric date and military time tooltip
        time=$(date +'%a %b %d %l:%M:%S%p' | tr -s ' ')
        date=$(date "+%Y-%m-%d")
        echo "{\"text\":\"  $time\",\"tooltip\":\"$date\"}"
      '';
      on-click = ''wl-copy $(date "+%Y-%m-%d-%H%M%S"); notify-send "Date copied."'';
      format = "{}";
      return-type = "json";
      interval = 1;
      tooltip = true;
    };
    shortClockModule = {
      exec = "echo '  '$(date +'%l:%M%p' | sed 's/^ //')";
      on-click = ''wl-copy $(date "+%Y-%m-%d-%H%M%S"); notify-send "Date copied."'';
      interval = 60;
      tooltip = false;
    };

    # Tray, gamemode, bluetooth, and network tray modules
    trayModule = {
      spacing = 5;
    };
    networkModule = {
      format-ethernet = "󰈀";
      format-wifi = "";
      format-disconnected = "󰖪";
      format-linked = "";
      tooltip-format-ethernet = "{ipaddr}\n{ifname} ";
      tooltip-format-wifi = "{ipaddr}\n{essid} ({signalStrength}%)";
      tooltip-format-disconnected = "Disconnected";
    };
    bluetoothModule = {
      format = "";
      format-disabled = "";
      format-no-controller = "";
      tooltip-format-on = "No devices connected.";
      tooltip-format-connected = "{num_connections} connected\n{device_enumerate}";
      tooltip-format-enumerate-connected = "{device_alias}";
      tooltip-format-enumerate-connected-battery = "{device_alias} {device_battery_percentage}%";
      on-click = "rofi-bluetooth";
    };
    scratchpadModule = {
      format = "   {count}";
      show-empty = false;
      tooltip = true;
      tooltip-format = "{title}";
    };
    gamemodeModule = {
      format = "{glyph}";
      glyph = "󰖺";
      hide-not-running = true;
      use-icon = true;
      icon-spacing = 3;
      icon-size = 19;
      tooltip = true;
      tooltip-format = "Gamemode On";
    };

    # Special per-bar modules
    notificationModule = {
      exec = pkgs.writeScript "notificationScript" ''
        # Run makoctl mode and store the output in a variable
        mode_output=$(makoctl mode)

        # Extract the second line after "default"
        mode_line=$(echo "$mode_output" | sed -n '/default/{n;p}')

        # Print the notification status with the tooltip
        if [[ "$mode_line" == "do-not-disturb" ]]; then
          printf '{"text":"󱆥  Off","class":"disabled","tooltip":"Notifications Disabled."}'
        else
          printf '{"text":"  On","tooltip":"Notifications Enabled."}';
        fi
      '';
      format = "{}";
      return-type = "json";
      interval = 2;
      on-click = "makotoggle";
    };
    weatherModule = {
      exec = let
        weatherConf = pkgs.writeText "weather.jsonc" ''
	  {
            "logo": {
              "source": "none"
            },
            "modules": [
              {
                "type": "weather",
                "outputFormat": "%0A%t%0A%C%0A%l"
              }
            ]
          }
	'';
      in pkgs.writeScript "weatherScript" ''
        # Fetch weather data
	fetch=$(fastfetch -c ${weatherConf} | sed 's/[[:space:]]*$//')
	temp=$(echo "$fetch" | sed -n '2s/^\+//p')
	condition=$(echo "$fetch" | sed -n '3p')
	location=$(echo "$fetch" | sed -n '4p')

        # Map weather conditions to emojis
        case "$condition" in
          "Clear"|"Sunny") emoji="☀️";;
          "Cloudy"|"Partly cloudy"|"Overcast") emoji="☁️";;
          "Rain") emoji="🌧️";;
          "Drizzle") emoji="🌦️";;
          "Thunderstorm") emoji="⛈️";;
          "Snow") emoji="❄️";;
          "Mist"|"Fog"|"Haze") emoji="🌫️";;
          *) emoji="🌍";; # Default emoji for unknown
        esac

        # Display weather emoji and temperature
        echo {\"text\":\"$emoji $temp\",\"tooltip\":\"$location: $condition\"}
      '';
      format = "<span font_size='11pt'>{}</span>";
      return-type = "json";
      interval = 150;
    };
    # Laptop modules
    backlightModule = {
      format = "{icon}  {percent}%";
      format-icons = ["" "󰖨"];
      tooltip = false;
    };
    batteryModule = {
      interval = 60;
      states = {
        warning = 30;
        critical = 15;
      };
      format = "{icon}   {capacity}%";
      format-icons = ["" "" "" "" ""];
    };
  in {
    enable = true;
    settings = {
      display1 = {
        name = "bar1";
        position = "top";
        layer = "bottom";
        output = ["HDMI-A-1"];
        modules-left = ["sway/workspaces" "sway/window"];
        modules-right = [
          "pulseaudio"
          "cpu"
          "memory"
          "custom/vram"
          "custom/clock-long"
          "gamemode"
          "sway/scratchpad"
          "tray"
          "bluetooth"
          "network"
        ];
        "sway/workspaces" = swayWorkspacesModule;
        "sway/window" = swayWindowsModule;
        "pulseaudio" = pulseModule;
        "cpu" = cpuModule;
        "memory" = ramModule;
        "custom/vram" = vramModule;
        "custom/clock-long" = longClockModule;
        "gamemode" = gamemodeModule;
        "sway/scratchpad" = scratchpadModule;
        "tray" = trayModule;
        "bluetooth" = bluetoothModule;
        "network" = networkModule // {interface = "enp*";};
      };
      display2 = {
        name = "bar2";
        position = "top";
        layer = "bottom";
        output = ["DVI-I-1"];
        modules-left = ["sway/workspaces" "sway/window"];
        modules-right = [
          "pulseaudio"
	  "custom/weather"
          "cpu"
          "memory"
          "custom/vram"
          "custom/clock-short"

        ];
        "sway/workspaces" = swayWorkspacesModule;
        "sway/window" = swayWindowsModule;
        "pulseaudio" = pulseModule;
	"custom/weather" = weatherModule;
        "cpu" = cpuModule;
        "memory" = ramModule;
        "custom/vram" = vramModule;
        "custom/clock-short" = shortClockModule;
      };
      displayLap = {
        name = "laptop";
        position = "top";
        layer = "bottom";
        output = ["LVDS-2"];
        modules-left = ["sway/workspaces" "sway/window"];
        modules-right = [
          "pulseaudio"
          "custom/media"
          "custom/weather2"
          "cpu"
          "memory"
          "custom/vram"
          "backlight"
          "battery"
          "custom/clock-long"
          "gamemode"
          "sway/scratchpad"
          "tray"
          "bluetooth"
          "network"
        ];
        "sway/workspaces" = swayWorkspacesModule;
        "sway/window" = swayWindowsModule;
        "pulseaudio" = pulseModule;
        "cpu" = cpuModule;
        "memory" = ramModule;
        "custom/vram" = vramModule;
        "backlight" = backlightModule;
        "battery" = batteryModule;
        "custom/clock-long" = longClockModule;
        "sway/scratchpad" = scratchpadModule;
        "tray" = trayModule;
        "bluetooth" = bluetoothModule;
        "network" = networkModule;
      };
    };
    style = ''
      * {
        border: 0;
        border-radius: 0;
        min-height: 0;
        font-family: ${outputs.look.fonts.main}, ${outputs.look.fonts.nerd};
        font-size: 15.5px;
        color: #${outputs.look.colors.text};
      }
      #waybar {
        background: #${outputs.look.colors.bar};
      }
      #workspaces {
        padding: 0 6px 0 0;
      }
      #tray {
        padding: 0 2px 0 5px;
      }
      #network {
        padding: 0 10px 0 4px;
      }
      #network.disconnected,#bluetooth.off {
        color: #424242;
      }
      #bluetooth {
        margin: 0 6px 0 4px;
        font-size: 13.4px;
      }
      #workspaces button {
        padding: 0 3px;
        color: white;
        border-bottom: 3px solid transparent;
        min-width: 20px;
      }
      #workspaces button.visible {
        border-bottom: 3px solid #${outputs.look.colors.prime};
        background: #${outputs.look.colors.mid};
      }
      #workspaces button.urgent {
        border-bottom: 3px solid #${outputs.look.colors.urgent};
      }
      #workspaces button:hover {
        box-shadow: none;
        background: #${outputs.look.colors.light};
      }
      #scratchpad {
        margin-left: 2px;
      }
      #cpu, #memory, #custom-vram, #custom-media, #custom-clock-long, #custom-clock-short, #backlight, #battery, #custom-weather, #custom-weather2, #custom-notifs {
        margin: 0 5px 0 2px;
      }
      #cpu {
        border-bottom: 3px solid #f90000;
      }
      #memory {
        border-bottom: 3px solid #4bffdc;
      }
      #custom-vram {
        border-bottom: 3px solid #33FF00;
      }
      #custom-media {
        border-bottom: 3px solid #ffb066;
      }
      #custom-clock-long {
        border-bottom: 3px solid #0a6cf5;
      }
      #custom-clock-short {
        border-bottom: 3px solid #0a6cf5;
      }
      #backlight {
        border-bottom: 3px solid #5ffca3;
      }
      #battery {
        border-bottom: 3px solid #fcfc16;
      }
      #custom-media.paused {
        color: #888;
      }
      #custom-weather {
        border-bottom: 3px solid #${outputs.look.colors.prime};
      }
      #custom-weather2 {
        border-bottom: 3px solid #c75bd3;
      }
      #custom-notifs {
        border-bottom: 3px solid #${outputs.look.colors.prime};
      }
      #custom-notifs.disabled {
        color: #888;
      }
      #pulseaudio {
        margin-right: 5px;
      }
      #pulseaudio.muted {
        color: #424242;
      }
    '';
  };
}

