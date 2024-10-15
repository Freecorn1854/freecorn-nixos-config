# Custom packages, that can be defined similarly to nixpkgs
{ pkgs ? import <nixpkgs> {} }: {

  vboxlocal = pkgs.callPackage ./vbox/vboxlocal.nix {
    # decare depts

    libIDL = pkgs.gnome2.libIDL;
    qtbase = pkgs.kdePackages.qtbase;
    qtsvg = pkgs.kdePackages.qtsvg;
    qttools = pkgs.kdePackages.qttools;
    qtwayland = pkgs.kdePackages.qtwayland;
    qtx11extras = pkgs.libsForQt5.qt5.qtx11extras;
    wrapQtAppsHook = pkgs.kdePackages.wrapQtAppsHook;

  };
}




