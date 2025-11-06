{
  config,
  pkgs,
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
          monitor = "";
          path = "screenshot";
          blur_passes =3;
          blur_size=10;
        }
      ];
      auth = {
        fingerprint = {
          enabled = true;
          ready_message = "Scan fingerprint or input password";
          present_message = "Scanning";
          retry_delay = 240;
        };
      };
      label = [
        {
        monitor = "";
        text = "$TIME";
        font_size = 90;
        font_family = "JetBrains Mono Medium";
        halign = "right";
        valign = "top";
        }
        {
          monitor = "";
          text = "$FPRINTPROMPT";
          font_family = "JetBrains Mono Medium";
          font_size = 50;

        }
      ];
    };
  };

}
