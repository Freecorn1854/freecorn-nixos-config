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
      # QEMU aliases
      vmrun-arch = "qemu-system-x86_64 -enable-kvm -m 4G -drive file=/home/freecorn/arch.img,format=qcow2 -nographic -smp 2";
      vmrun-freebsd = "qemu-system-x86_64 -enable-kvm -m 4G -drive file=/home/freecorn/freebsd.img,format=qcow2 -nographic -smp 2";

      # NixOS aliases
      nixclean = "sudo nix-store --gc; nix-collect-garbage -d";
      nixpurge = "sudo nix-collect-garbage --delete-old";
      nixoptimize = "sudo nix store optimise";

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
