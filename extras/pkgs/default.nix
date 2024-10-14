# Custom packages, that can be defined similarly to nixpkgs
{pkgs, ...}: {
  vboxlocal = pkgs.callPackage ./vbox/vboxlocal.nix {};
}
