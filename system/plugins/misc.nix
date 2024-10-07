{ config, pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [ 
    # misc system packages
    ffmpeg
  ];
}
