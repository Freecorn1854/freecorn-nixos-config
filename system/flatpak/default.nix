{config, pkgs, outputs, ...}: {
  imports = [
    ./misc.nix
    ./sober.nix
  ];
    services.flatpak = {
        remotes = [
            {
                name = "flathub";
                location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
            }
	];
   };
}
