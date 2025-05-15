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
        hide_cursor = false;
      };
      animations.enabled = false;
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
          retry_delay = 240;
        };
      };
      label = {
        text = "$TIME";
        font_size = 90;
        font_family = "Monospace";
        halign = "right";
        valign = "top";
      };
    };
  };

}
