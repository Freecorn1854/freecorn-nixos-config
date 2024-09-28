# Help is available in the configuration.nix(5) man page and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  # Import home manager
  homeManager = fetchTarball
    "https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz";
in

{
  imports =
    [ # add plugins/packages that require to be install on system instead of home
      ./hardware-configuration.nix
      ./plugins/users/freecorn.nix
      ./plugins/programs/qemukvm.nix
      "${homeManager}/nixos"
    ];

  # Allow unfree packages and add the unstable channel
  nixpkgs = {
    config = {
      allowUnfree = true;
      packageOverrides = pkgs: {
        unstable = import (
          fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz"
        ){
          inherit pkgs;
	  # Allow unfree is needed in both the main nixpkgs and unstable
          config.allowUnfree = true;
        };
      };
    };
  };

  # allow non nix programs to run
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
  ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;
  boot.supportedFilesystems = [ "ntfs" ];

  # Enable networking
  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Edmonton";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

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
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # add default shell
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  users.users.freecorn.useDefaultShell = true;

  # Install firefox.
  programs.firefox.enable = true; 

  # Uninstall nano EW
  programs.nano.enable = false;

  # Installs steam cuz i wanna play my games man :Waa:
  programs.steam.enable = true;

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    wget
    fastfetch
    vesktop
    # unstable.steam # an example for how you would use a specfic unstable package
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [  ];
  networking.firewall.allowedUDPPorts = [  ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05";
}
