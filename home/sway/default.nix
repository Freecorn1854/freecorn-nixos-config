{config, pkgs, outputs, ...}: {
  imports = [
    ./hardware.nix
    ./hotkeys.nix
    ./swaybar.nix
    # ./swayshot.nix
  ];

  # Enable Sway and write some scripts
  wayland.windowManager.sway = {
    enable = true;
    package = null;
    wrapperFeatures.gtk = true;
  };
}
