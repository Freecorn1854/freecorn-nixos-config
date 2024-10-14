{config, pkgs, outputs, ...}: {
  virtualisation = {
    libvirtd = {
      enable = true;
      onBoot = "ignore";
      onShutdown = "shutdown";
      qemu = {
        ovmf = {
          enable = true;
          packages = [
	    pkgs.OVMFFull.fd
	    pkgs.pkgsCross.aarch64-multiplatform.OVMF.fd
	  ];
        };
        swtpm.enable = true;
      };
    };
    spiceUSBRedirection.enable = true;
  };

#  virtualisation.virtualbox.host.enable = true;
#  virtualisation.virtualbox.host.enableExtensionPack = true;

  environment.systemPackages = with pkgs; [
    virt-manager
    virtiofsd
    dnsmasq
    spice-vdagent
    vboxlocal
  ];

  # dept of libvirtd ig
  security.polkit.enable = true;
}
