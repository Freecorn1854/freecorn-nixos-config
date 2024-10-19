{pkgs, config, outputs, ...}: {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "alanpeabody";
      plugins = ["git"];
    };
    shellAliases = {

      # NixOS aliases
      nixclean = "sudo nix-store --gc; nix-collect-garbage -d";
      nixpurge = "sudo nix-collect-garbage --delete-old";
      nixoptimize = "sudo nix store optimise";
      nixcleanall = "nixclean; nixpurge; nixoptimize";

      # Flake commands
      flakedate = "sudo nix flake update /etc/nixos";
      sysswitch = "sudo nixos-rebuild switch --flake /etc/nixos";
      homeswitch = "home-manager switch --flake /etc/nixos";
      nixswitch = "sysswitch; homeswitch;";
      nixdate = "flakedate && sysswitch; homeswitch";

      # Unzip to 7za
      unzip = "7za x";

    };
    initExtra = ''
      ${pkgs.any-nix-shell}/bin/any-nix-shell zsh --info-right | source /dev/stdin;
      setopt HIST_IGNORE_SPACE
      setopt RM_STAR_WAIT
    '';
  };
}
