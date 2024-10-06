{ config, pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [ 
    # screenshot functionality
    grim
    slurp
    jq
    lm_sensors
    imv
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    mako # notification system developed by swaywm maintainer
    wdisplays
    # packages needed for waybar config
    pciutils
    bc
  ];

  # Enable the gnome-keyring secrets vault.
  # Will be exposed through DBus to programs willing to store secrets.
  services.gnome.gnome-keyring.enable = true;

  # enable Sway window manager
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
}
