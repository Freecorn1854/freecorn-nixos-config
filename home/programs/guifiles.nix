{pkgs, ...}: {
  # Files that only make sense with a GUI
  home.file = {
#    ".face" = {
#      source = ../assets/user-icon.png;
#    };
    ".wallpapers" = {
      source = ../assets/wallpapers;
      recursive = true;
    };
    ".icons/default" = {
      source = "${pkgs.simp1e-cursors}/share/icons/Simp1e-Dark";
    };
  };
}
