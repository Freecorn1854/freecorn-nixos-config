{pkgs, ...}: {
  # Swappy config file
  home = {
    packages = with pkgs; [
      swappy
    ];
    file = let 
      # Swappy config, for screenshot editing
      swappyConfig = ''
        [Default]
        early_exit=true
        save_dir=$HOME/Pictures/Screenshots
      '';
    in {
      # Swappy's config
      ".config/swappy/config".text = swappyConfig;
    };
  };
}
