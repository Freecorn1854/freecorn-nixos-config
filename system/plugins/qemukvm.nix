{config, pkgs, ...}: {
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

  environment.systemPackages = with pkgs; [
    virt-manager
    virtiofsd
    dnsmasq
    spice-vdagent
    virtualbox
  ];
}
