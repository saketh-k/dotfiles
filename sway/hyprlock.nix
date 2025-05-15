{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  ...
}:
{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        no_fade_in = true;
        hide_cursor = false;
      };
      background = [
        {
          path = "screenshot";
          blur_passes =3;
          blur_size=10;
        }
      ];
      auth = {
        fingerprint = {
          enabled = true;
          ready_message = "Scan yer fingie";
          present_message = "Scanning";
          retry_dely = 240;
        };
      };
    };
  };

}
