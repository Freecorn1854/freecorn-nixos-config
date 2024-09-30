{config, pkgs, outputs, ...}: {
  wayland.windowManager.sway = {
    config.bars = [
      {
        position = "top";
	colors.background = "#20202000";
	statusCommand = "i3status";
	fonts = {
	  names = ["Ubuntu"];
	  size = 11.5;
	};
      }
    ];
  };
  programs.i3status = {
    enable = true;
    general = {
      interval = 1;
    };
    modules = {
      "ipv6".enable = false;
      "wireless _first_".enable = false;
      "ethernet _first_".enable = false;
      "battery all".enable = false;
      "disk /".enable = false;
      "tztime local" = {
       settings = {
         format = "%I:%M";
	 };
      };
    };
  };
}

