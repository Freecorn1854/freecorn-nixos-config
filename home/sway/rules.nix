{config, pkgs, outputs, ...}: {
  # Enable Sway and write some scripts
  wayland.windowManager.sway = {
    config = {
      # Rules
      window = {
        border = outputs.look.border.int;
        titlebar = true;
        commands = [
           {
            criteria = {title = "^GlobalShot";};
            command = ''floating enable, fullscreen enable global, mark borderless'';
          }
        ];
      };
   };
 };
}

