{outputs, ...}: {

  services = {
    vaultwarden = {
      enable = true;
      config = {
        DOMAIN = "https://warden.freecorn1854.win";
        SIGNUPS_ALLOWED = false;
        ROCKET_ADDRESS = "127.0.0.1";
        ROCKET_PORT = 8222;
        ROCKET_LOG = "critical";

      };
    };
    nginx.virtualHosts."warden.freecorn1854.win" =  {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:8222";
        proxyWebsockets = true;
      };
    };
  };
}
