{config, pkgs, outputs, ...}: {
  imports = [
    ./hardwaremac.nix
    ./hotkeys.nix
    ./swaybar.nix
    ./swayshot.nix
    ./theme.nix
    ./autostart.nix
    ./rules.nix
    ./swaylock.nix
  ];

  # Enable Sway and write some scripts
  wayland.windowManager.sway = {
    enable = true;
    package = null;
    wrapperFeatures.gtk = true;
  };
}
