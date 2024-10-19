{ config, pkgs, options, lib, outputs, inputs, ... }:
let
  # Secrets and passwords
#  secrets = import ./secrets.nix;
in

{
  imports = [
#    ./secrets.nix
    ./hardware.nix 
    ./freecorn.nix
    ./jimbo.nix
    ./vaultwarden.nix
#    ./wireguard.nix
#    ./neovim.nix 
  ];
  #flake

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader
  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
  };

  # Enable network manager applet
  programs.nm-applet.enable = true;

  # Set your time zone.
  time.timeZone = America/Edmonton;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # allow non nix programs to run
  programs.nix-ld.enable = true; 
  # Define a users and groups


  # RTL-SDR Support
  hardware.rtl-sdr.enable = true;
  boot.kernelParams = [ "modprobe.blacklist=dvb_usb_rtl28xxu" ]; # blacklist dunb driver

  # Docker :(((
  virtualisation.docker.enable = true;

  # OpenWebRX
#  services.openwebrx.enable = true;

  # PufferPannel
  services = {
    pufferpanel = {
      enable = true;
      environment = {
        PUFFER_WEB_HOST = ":5010";
        PUFFER_PANEL_SETTINGS_MASTERURL = "https://ppanel.freecorn1854.win";
	PUFFER_PANEL_REGISTRATIONENABLED = "false";
       # PUFFER_PANEL_EMAIL_PROVIDER = "smtp";
       # PUFFER_PANEL_EMAIL_HOST = "mx.${outputs.secrets.jimDomain}:587";
       # PUFFER_PANEL_EMAIL_FROM = "noreply@${outputs.secrets.jimDomain}";
       # PUFFER_PANEL_EMAIL_USERNAME = "noreply@${outputs.secrets.jimDomain}";
       # PUFFER_PANEL_EMAIL_PASSWORD = outputs.secrets.noreplyPassword;
      };
      extraPackages = with pkgs; [ bash curl gawk gnutar gzip ];
      package = pkgs.buildFHSEnv {
        name = "pufferpanel-fhs";
        meta.mainProgram = "pufferpanel-fhs";
        runScript = lib.getExe pkgs.pufferpanel;
        targetPkgs = pkgs': with pkgs'; [ icu openssl zlib ];
      };
    };
  };

  # NGINX :3
  services.nginx = {
    enable = true;
    package = (pkgs.nginx.override {
      modules = with pkgs.nginxModules; [ rtmp ];
    });
    recommendedTlsSettings = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;
    recommendedProxySettings = true;

    # Homepage HTML
    virtualHosts = {
      "freecorn1854.win" = {
        enableACME = true;
        addSSL = true;
        root = "/var/www/cornweb";
      };

      # non-free websites
      "nonfree.freecorn1854.win" = {
        enableACME = true;
        forceSSL = true;
        root = "/var/www/non-free";
      };

      # websdr server
      "ppanel.freecorn1854.win" = {
        enableACME = true;
        forceSSL = true;
        locations."/" = {
          proxyPass = "http://127.0.0.1:5010";
          proxyWebsockets = true;
	};
      };

      # Nextcloud Proxy
      "cloud.freecorn1854.win" = {
        enableACME = true;
        addSSL = true;
        locations."/" = {
          proxyWebsockets = true;
          extraConfig = ''
            location /.well-known/carddav {
              return 301 $scheme://$host/remote.php/dav;
            }
            location /.well-known/caldav {
              return 301 $scheme://$host/remote.php/dav;
	    }
          '';
        };
      };
    };
    appendConfig = ''
      rtmp {
        server {
          listen 1935;
          chunk_size 4096;
          allow publish all;
          application stream {
            record off;
            live on;
            allow play all;
          }
        }
      }
    '';
  };

  # Nextcloud server
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud29;
    hostName = "cloud.freecorn1854.win";
    datadir = "/mnt/nextcloud";
    https = true;
    config = {
      adminuser = "freecorn";
      adminpassFile = "/mnt/nextcloud/password.txt";
    };
    settings = {
      trusted_proxies = [ "127.0.0.1" ];
      trusted_domains = [ "cloud.freecorn1854.win" ];
      overwriteprotocol = "https";
    };
  };

  # Get certificates for Coturn
#  security.acme = {
#    acceptTerms = true;
#    defaults.email = secrets.cornEmail;
#  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Packages installed in system profile
  environment.systemPackages = with pkgs; [
    # firefox
    wget
    x11vnc
    fastfetch
    ffmpeg
    system-config-printer
    libcaption
    git
    rtl-sdr
    steam-run
    # openwebrx
    qbittorrent
    vim
  ];

  # Enable the OpenSSH daemon.
  services.openssh = {
  enable = true;
    settings = {
      PermitRootLogin = "no";
      PrintLastLog = "no";
      PasswordAuthentication = false;
    };
    openFirewall = true;
  };

  # Hostname and networking
  networking = {
    hostName = "freecornserver";
    networkmanager.enable = true;
    firewall = {
      allowedTCPPorts = [ 
        1935 # RTMP
#        4455 # VR
        80 443 # Nginx
        1234 # rtl_tcp
#        25565 # minecraft port
         8222
      ];
      allowedUDPPorts = [ 
#        4455
#        24454 # minecraft vc mod
      ];
    };
    nftables = {
      enable = true;
      tables = {
        forwarding = {
          family = "ip";
          content = ''
            chain PREROUTING {
              type nat hook prerouting priority dstnat; policy accept;
              tcp dport { 9943, 9944 } dnat to 10.0.0.97 comment "ALVR"
            }
            chain POSTROUTING {
              type nat hook postrouting priority 100; policy accept;
              oifname "enp2s0" masquerade
            }
          '';
        };
      };
    };
  };

  

# :3
     

  # NFS server
#  services.nfs.server = {
#    enable = true;
#    exports = ''
#      /export/freecornNFS *(rw,no_subtree_check)
#    '';
#  };

  # Copy and link the NixOS configuration file to (/run/current-system/configuration.nix).
  system.copySystemConfiguration = true;

  # Don't change this
  system.stateVersion = "24.05";
}
