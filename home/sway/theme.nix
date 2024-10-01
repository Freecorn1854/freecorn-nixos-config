{config, pkgs, outputs, ...}: {
  # Enable Sway and write some scripts
  wayland.windowManager.sway = {
    enable = true;
    #package = pkgs.unstable.sway;
    wrapperFeatures.gtk = true;
    checkConfig = false;
    config = {
      fonts = {
        names = ["Ubuntu"];
        size = 10.5;
      };
      gaps = {
        inner = 5;
        smartGaps = true;
      };
    };
  };
}
