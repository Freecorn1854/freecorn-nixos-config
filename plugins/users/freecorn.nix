{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.freecorn = {
    isNormalUser = true;
    description = "Freecorn";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Define home manager programs and configs
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.freecorn = { config, pkgs, ... }: {
      # Install user programs
      home.packages = with pkgs; [
        vlc
        git
        alsa-utils
        unstable.blender
	unstable.sdrpp
	gparted
      ];

      # extra programs, what i shorthand to "plugins", imported relatively that are too long to be added in the main file.
      imports = [
        ../programs/neovim.nix
        ../programs/minecraft.nix
        ../programs/obs.nix
        ../programs/remotedesktop.nix
        ../programs/libreoffice.nix
        ../programs/emulators.nix
        ../programs/zsh.nix
      ];

      # Don't change this
      home.stateVersion = "24.05";
    };
  };
}
