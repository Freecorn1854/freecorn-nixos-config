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
          bg = "~/.wallpapers/2.png fill";
	  adaptive_sync = "off";
        };
      };
      # HID device config
      input = {
        "7119:2208:HID_1bcf:08a0_Mouse" = {
          pointer_accel = "-0.875";
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
