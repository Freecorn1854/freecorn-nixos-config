{ pkgs, ... }:
{
  networking = {
    wireless.iwd.enable = true;
    enableB43Firmware = true;
  };

  environment.systemPackages = with pkgs; [
    unstable.impala
  ];
}

