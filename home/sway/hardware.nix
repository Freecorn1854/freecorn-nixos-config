{config, pkgs, outputs, ...}: {

  imports = [
    ./wallpapers.nix
  ];

  wayland.windowManager.sway = {
    config = {
      output = {
        HDMI-A-1 = {
          pos = "1280 104";
          mode = "1920x1080@60Hz";
          max_render_time = "3";
          bg = "~/.wallpapers/1.png fill";
          scale = "1";
          adaptive_sync = "on";
        };
        DVI-I-1 = {
          pos = "0 228";
          mode = "1280x1024@75Hz";
          max_render_time = "3";
          bg = "~/.wallpapers/1.png fill";
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
