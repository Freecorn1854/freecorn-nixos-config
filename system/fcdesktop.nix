{ config, pkgs, ... }: {
  # add plugins/packages that require to be install on system instead of home
  imports = [
    ./fcdesktophardware.nix
    ./users/freecorn.nix
    ./programs/qemukvm.nix
  ];

  # flake.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # allow non nix programs to run
  programs.nix-ld.enable = true;

  # Set your time zone.
  time.timeZone = "America/Edmonton";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Enable the X11 windowing system, uneeded for Wayland
  #services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
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