{pkgs, ...}: {
  # OBS with plugins
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-pipewire-audio-capture
      obs-webkitgtk
      obs-multi-rtmp
      obs-vkcapture
      obs-tuna
      looking-glass-obs
    ];
  };
}
