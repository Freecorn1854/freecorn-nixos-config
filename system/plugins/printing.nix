{pkgs, ...}: {
  # Enable printing
  services = {
    printing = {
      enable = true;
      drivers = with pkgs; [hplip];
      webInterface = false;
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };

  # Install programs system-wide
  environment.systemPackages = with pkgs; [
    system-config-printer
  ];
}
