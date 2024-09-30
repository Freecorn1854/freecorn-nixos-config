{config, pkgs, outputs, ...}: {
  wayland.windowManager.sway = {
    config.bars = [
      {
        position = "top";
	colors.background = "#20202000";
	statusCommand = "${pkgs.i3status}/bin/i3status";
	names = ["Ubuntu"];
	fonts.size = 13.0;
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
