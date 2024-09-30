{outputs, ...}: {
  # Enable a terminal emulator
  programs.foot = {
    enable = true;
    server.enable = false;
    settings = {
      main = {
        term = "xterm-256color";
        font = "UbuntuMono Nerd Font:size=14.7";
      };
    };
  };
}

