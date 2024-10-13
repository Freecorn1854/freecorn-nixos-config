# credits for this github repo link https://github.com/Bear-03/dotfiles/ for the sober hotfix!

{ config, pkgs, inputs, ... }:
let
    inherit (inputs) sober nix-flatpak;

    soberPatchedPath = pkgs.writeText "sober.flatpakrepo" (
        builtins.replaceStrings ["[Flatpak Ref]"] ["[Flatpak Repo]"] (builtins.readFile sober.outPath)
    );
in
{
    services.flatpak = {
        remotes = [
            {
                name = "sober";
                location = "file://${soberPatchedPath}";
            }
        ];
        packages = [
            { appId = "org.vinegarhq.Sober"; origin = "sober"; }
        ];
    };
}
