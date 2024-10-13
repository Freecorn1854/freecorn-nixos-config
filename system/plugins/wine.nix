{ config, pkgs, lib, ... }: {

  environment.systemPackages = with pkgs; [
    # winetricks (all versions)
    winetricks

    # wine (unstable)
    wineWowPackages.staging
  ];
}
