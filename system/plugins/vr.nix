# another attempt at vr on linux!
# alvr since its a really really old version on the repos, it wont be included here.
{ config, pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [ 
    sidequest
  ];
}

