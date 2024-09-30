{config, pkgs, outputs, ...}: {
  wayland.windowManager.sway = {
    config.bars = [
      {
        position = "top";
	colors.background = "#20202000";
      }
    ];
  };
  programs.i3status = {
    enable = true;
    modules = {
      "ipv6".enable = false;
      "wireless _first_".enable = false;
      "ethernet _first_".enable = false;
      "battery all".enable = false;
      "disk /".enable = false;
    };
  };
}
