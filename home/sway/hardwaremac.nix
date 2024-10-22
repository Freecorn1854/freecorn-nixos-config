{config, pkgs, outputs, ...}: {

  imports = [
    ./wallpapers.nix
  ];

  wayland.windowManager.sway = {
    config = {
      output = {
        LVDS-1 = {
          pos = "0 0";
          mode = "1440x900@59.901Hz";
          max_render_time = "3";
          bg = "~/.wallpapers/1.png fill";
          scale = "1";
          adaptive_sync = "off";
        };
      };
      # HID device config
      input = {
        "1452:556:bcm5974" = {
          pointer_accel = "0";
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
