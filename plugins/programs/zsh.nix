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
      vmrun-arch = "qemu-system-x86_64 -enable-kvm -m 4G -drive file=/home/freecorn/arch.img,format=qcow2 -nographic -smp 2";
    };
    initExtra = ''
      ${pkgs.any-nix-shell}/bin/any-nix-shell zsh --info-right | source /dev/stdin;
      setopt HIST_IGNORE_SPACE
      setopt RM_STAR_WAIT
    '';
  };
}
