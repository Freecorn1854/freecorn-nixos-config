{config, pkgs, outputs, ...}: {

  imports = [
    ./wallpapers.nix
  ];

  wayland.windowManager.sway = {
    config = {
      output = {
        HDMI-A-1 = {
          pos = "1280 0";
          mode = "1920x1080@60Hz";
          max_render_time = "3";
          bg = "~/.wallpapers/1.png fill";
          scale = "1";
          adaptive_sync = "off";
        };
        DVI-I-1 = {
          pos = "0 124";
          mode = "1280x1024@75Hz";
          max_render_time = "3";
          bg = "~/.wallpapers/1.png fill";
	  adaptive_sync = "off";
        };
      };
      # HID device config
      input = {
        "0:14373:USB_OPTICAL_MOUSE" = {
          pointer_accel = "-0.1";
        };
        "*" = {
          accel_profile = "flat";
          dwt = "disabled";
          natural_scroll = "disabled";
        };
      };
    };
  };
}
