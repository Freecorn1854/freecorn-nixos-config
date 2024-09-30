# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{pkgs, inputs, outputs, ...}: {
  # import programs
  imports = [
    ./programs/neovim.nix
    ./programs/minecraft.nix
    ./programs/obs.nix
    ./programs/remotedesktop.nix
    ./programs/libreoffice.nix
    ./programs/emulators.nix
    ./programs/zsh.nix
    ./programs/misc.nix
  ];

  nixpkgs = {
    # You can add overlays here
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  # Common programs I'll need everywhere
  home.packages = with pkgs; [
    home-manager
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
