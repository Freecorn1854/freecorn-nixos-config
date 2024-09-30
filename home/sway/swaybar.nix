{config, pkgs, outputs, ...}: {
  wayland.windowManager.sway = {
    config.bars = [
      {
        position = "top";
        statusCommand = null;
      };
    ];
  };
  programs.i3status = {
    enable = true;
    modules = {
      "ipv6".enable = false;
      "disk /".enable = false;
      "run_watch DHCP".enable = false;
      "run_watch VPN".enable = false;
      "wireless wlan0".enable = false;
      "ethernet eth0".enable = false;
      "battery 0".enable = false;
    };
  };
}
