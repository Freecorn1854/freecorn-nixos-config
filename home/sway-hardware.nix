{config, pkgs, outputs, ...}: {
  wayland.windowManager.sway = {
    config = {
      # HID device config
      input = {
        "0:14373:USB_OPTICAL_MOUSE" = {
          pointer_accel = "-0.9";
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
