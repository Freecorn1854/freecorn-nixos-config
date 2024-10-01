{config, pkgs, outputs, ...}: {
  # Enable Sway and write some scripts
  wayland.windowManager.sway = {
    enable = true;
    #package = pkgs.unstable.sway;
    wrapperFeatures.gtk = true;
    checkConfig = false;
    config = {
      # Theming settings
      colors = {
        focused = {
          border = "#${outputs.look.colors.prime}";
          background = "#${outputs.look.colors.prime}";
          text = "#FFFFFF";
          indicator = "#${outputs.look.colors.actSplit}";
          childBorder = "#${outputs.look.colors.prime}";
        };
        focusedInactive = {
          border = "#${outputs.look.colors.accent}";
          background = "#${outputs.look.colors.accent}";
          text = "#${outputs.look.colors.text}";
          indicator = "#${outputs.look.colors.split}";
          childBorder = "#${outputs.look.colors.accent}";
        };
        unfocused = {
          border = "#${outputs.look.colors.dark}";
          background = "#${outputs.look.colors.dark}";
          text = "#${outputs.look.colors.text}";
          indicator = "#${outputs.look.colors.split}";
          childBorder = "#${outputs.look.colors.split}";
        };
        urgent = {
          border = "#${outputs.look.colors.urgent}";
          background = "#${outputs.look.colors.urgent}";
          text = "#${outputs.look.colors.text}";
          indicator = "#${outputs.look.colors.urgent}";
          childBorder = "#${outputs.look.colors.urgent}";
        };
      };
      fonts = {
        names = ["${outputs.look.fonts.main}"];
        size = 10.5;
      };
      gaps = {
        inner = 5;
        smartGaps = true;
      };
    };
  };
}

