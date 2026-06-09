{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

{
  services.searx = {
    enable = true;
    redisCreateLocally = true;
    settings = {
      server.port = 8080;
      server.bind_address = "0.0.0.0";
      server.secret_key = "$SEARX_SECRET_KEY";

      general = {
        donation_url = false;
        contact_url = false;
        privacy_policy_url = true;
        enable_metrics = false;
      };

      # search = {};

      engines = [
        {
          name = "wolframalpha";
          shortcut = "wa";
          api_key = "$WOLFRAM_API_KEY";
          engine = "wolframalpha_api";
        }

      ];
    };
  };
}
