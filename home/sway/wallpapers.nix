{pkgs, ...}: {
  # Files that only make sense with a GUI
  home.file = {
    ".wallpapers" = {
      source = ../assets/wallpapers;
      recursive = true;
    };
 };
}

