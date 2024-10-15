{pkgs, ...}: {
  services = {
    # Configure greetd for "auto" login (single user only)
    greetd = let
      startSway = pkgs.writeScript "startsway" ''
        # Sway/Wayland
	export WLR_RENDERER=vulkan
        export XDG_CURRENT_DESKTOP=sway
        export QT_QPA_PLATFORM="wayland;xcb"

        # Start Sway
        sway
      '';
    in {
      enable = true;
      restart = true;
      settings = {
        terminal = {
          vt = 2;
          switch = true;
        };
        default_session = {
          command = "${startSway}";
          user = "freecorn";
        };
      };
    };
  };
}
