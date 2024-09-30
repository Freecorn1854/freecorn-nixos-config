{pkgs, outputs, ...}: {
  # Define GTK theme settings
  gtk = {
    enable = true;
    font = {
      name = "Ubuntu";
      size = 11;
    };
    theme = {
      name = "Colloid-Dark";
      package = pkgs.colloid-gtk-theme.override {
        themeVariants = ["default"];
        colorVariants = ["dark"];
        sizeVariants = ["standard"];
        tweaks = ["black" "rimless" "normal"];
      };
    };
    iconTheme = {
      package = pkgs.papirus-icon-theme.override {color = "green";};
      name = "Papirus-Dark";
    };
    cursorTheme = {
      package = pkgs.simp1e-cursors;
      name = "Simp1e-Dark";
    };

    # GTK app bookmarks
    gtk3 = {
      bookmarks = [
        # Local
        "file:///home/freecorn/Downloads"
        "file:///home/freecorn/Documents"
        "file:///home/freecorn/Videos"
        "file:///home/freecorn/Pictures"
      ];

      # Disable shadows
      extraCss = ''
        * { outline-width: 0px; }
        decoration { box-shadow: none; }
      '';
    };

    # Stop gtk4 from being rounded
    gtk4.extraCss = ''
      window {
        border-top-left-radius:0;
        border-top-right-radius:0;
        border-bottom-left-radius:0;
        border-bottom-right-radius:0;
      }
    '';
  };
}
