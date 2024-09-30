{outputs, ...}: {
  # Enable a terminal emulator
  programs.foot = {
    enable = true;
    server.enable = false;
    settings = {
      main = {
        font = "Liberation Mono:size=13";
      };
    };
  };
}

