{config, pkgs, outputs, ...}: {
  # Enable Sway and write some scripts
  wayland.windowManager.sway = {
    config = {
      # Rules
      window = {
        border = outputs.look.border.int;
        titlebar = false;
        commands = [
           {
            criteria = {title = "^GlobalShot";};
            command = ''floating enable, fullscreen enable global'';
          }
          # Give apps that don't have them borders
          {
            criteria = {con_mark = "borderless";};
            command = ''border pixel ${outputs.look.border.string}'';
          }
          {
            criteria = {app_id = "firefox";};
            command = ''mark borderless'';
          }
          {
            criteria = {class = "steam";};
            command = ''mark borderless'';
          }
          {
            criteria = {app_id = "swappy";};
            command = ''mark borderless'';
          }
          {
            criteria = {app_id = "virt-manager";};
            command = ''mark borderless'';
          }
          {
            criteria = {window_role = "pop-up";};
            command = ''mark borderless'';
          }

        ];
      };
   };
 };
}

