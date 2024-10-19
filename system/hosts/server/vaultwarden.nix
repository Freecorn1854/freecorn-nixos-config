{outputs, ...}: {
  services = {
    vaultwarden = {
      enable = true;
      config = {
        DOMAIN = "https://warden.${outputs.secrets.cornDomain}";
        SIGNUPS_ALLOWED = false;
        ROCKET_ADDRESS = "127.0.0.1";
        ROCKET_PORT = 8222;
        ROCKET_LOG = "critical";

      };
    };
    nginx.virtualHosts."warden.${outputs.secrets.cornDomain}" =  {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:8222";
        proxyWebsockets = true;
      };
    };
  };
}
