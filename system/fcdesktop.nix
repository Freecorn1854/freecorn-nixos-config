{ config, pkgs, inputs, outputs, ... }: {
  # add plugins/packages that require to be install on system instead of home
  imports = [
    ./hardware/fcdesktop.nix
    ./users/freecorn.nix
    ./plugins/vms.nix
    ./plugins/sway.nix
    ./plugins/qt.nix
    ./plugins/plymouth.nix
    ./plugins/fonts.nix
    ./plugins/printing.nix
    ./plugins/vr.nix
    ./flatpak
    ./nixregs.nix
    ./plugins/wine.nix
    ./plugins/greetd-sway.nix
    ./plugins/misc.nix
  ];

  # flake.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # allow non nix programs to run
  programs.nix-ld.enable = true;

  # flatpak support
  services.flatpak.enable = true;

  nixpkgs.config.allowUnfree = true;

  # Set your time zone.
  time.timeZone = "America/Edmonton";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Enable the X11 windowing system, uneeded for Wayland
  #services.xserver.enable = true;

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.finalprev
#      outputs.overlays.additions
    ];
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true;
  };

  # add default shell
  programs.zsh.enable = true;

  # Uninstall nano EW
  programs.nano.enable = false;

  # steam has to be a system package or eles it doesnt open
  programs.steam.enable = true;

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable networking
  networking = {
    hostName = "FreecornDesktop";
    networkmanager.enable = true;
    #firewall = {
    #  allowedTCPPorts = [];
    #  allowedUDPPorts = [];
    #};
  };

  # Before changing this value read the docs on stateVersion
  system.stateVersion = "24.05";
}
