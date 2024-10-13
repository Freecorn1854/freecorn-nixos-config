{config, pkgs, outputs, ...}: {
  imports = [
    ./misc.nix
    ./sober.nix
  ];
    services.flatpak = {
    update.onActivation = true;
    uninstallUnmanaged = true;
        remotes = [
            {
                name = "flathub";
                location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
            }
	];
   };
}
