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
          blur_passes = 3;
          blur_size = 10;
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
          halign = "right";
          valign = "top";
        }
        {
          monitor = "";
          text = "$FPRINTPROMPT";
          font_size = 50;
        }
        {
          monitor = "";
          text = "cmd[update:1000] cat /sys/class/power_supply/BAT1/capacity";
          font_size = 120;
          valign = "top";
          halign = "left";
        }
      ];
    };
  };

}
