{pkgs, ...}: {
  home = {
    file = let 
      fastConf = ''
{
  "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
  "logo": {
    "source": "cornascii.txt",
    "color": {
      "1": "yellow",
      "2": "green",
    }
  },
  "display": {
    "separator": " \u001b[33m  ",
    "color": "green"
  },
  "modules": [
    {
      "type": "custom",
      "format": "\u001b[1mFreecorn's Shitty Computer :3"
    },
    {
      "type": "custom",
      "format": "\u001b[1m—————————————————————————————————————"
    },
    {
      "type": "host",
      "format": "{5} {2}",
      "key": "󰌢 "
    },
    {
      "type": "cpu",
      "key": " "
    },
    {
      "type": "gpu",
      "key": "󰢮 "
    },
    {
      "type": "disk",
      "folders": "/",
      "key": " "
    },
    {
      "type": "memory",
      "format": "{/1}{-}{/}{/2}{-}{/}{} / {}",
      "key": " "
    },
    {
      "type": "display",
      "compactType": "original",
      "key": "󰍹 "
    },

    {
      "type": "custom",
      "format": "\u001b[1m—————————————————————————————————————"
    },
    {
      "type": "os",
      "format": "{3} {12}",
      "key": "󰍛 "
    },
    {
      "type": "kernel",
      "format": "{1} {2}",
      "key": " "
    },
    {
      "type": "wm",
      "key": " "
    },
    {
      "type": "shell",
      "key": " "
    },
    {
      "type": "terminal",
      "key": " "
    },
    {
      "type": "packages",
      "key": "󰆧 "
    },
    {
      "type": "uptime",
      "key": "󰅐 "
    },
    {
      "type": "command",
      "text": "date -d @$(stat -c %W /) '+%a %b %d %r %Z %Y'",
      "key": "󰶡 "
    },

    {
      "type": "custom",
      "format": "\u001b[1m—————————————————————————————————————"
    },
    {
      "type": "custom",
      "format": "\u001b[90m    \u001b[31m󰀶   \u001b[32m   \u001b[33m   \u001b[34m󰨡   \u001b[35m   \u001b[36m   \u001b[37m"
    }
  ]
}      '';
    in {
      # Fastfetch config
      ".config/fastfetch/config.jsonc".text = fastConf;
    };
    packages = let 
      # Small Neofetch config
      pFetch = let
        smallConf = pkgs.writeText "smallconf.jsonc" ''
          {
            "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
            "logo": {
	      "type": "small"
            },
            "modules": [
              {
                "type": "os",
                "format": "{3} {12}",
                "key": "󰍛 "
              },
              {
                "type": "host",
                "key": "󰌢 "
              },
              {
                "type": "kernel",
                "format": "{1} {2}",
                "key": " "
              },
              {
                "type": "uptime",
                "key": "󰅐 "
              },
              {
                "type": "packages",
                "key": "󰆧 "
              },
              {
                "type": "memory",
                "format": "{/1}{-}{/}{/2}{-}{/}{} / {}",
                "key": " "
              }
            ]
          }
        '';
      in pkgs.writeScriptBin "pfetch"
        ''fastfetch --config ${smallConf}'';
    in with pkgs; [
      fastfetch pFetch
    ];
  };
}
