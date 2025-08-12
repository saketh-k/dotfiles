{lib, config, pkgs, ...}:

{
  programs.firefox = {
    enable = false;
    
    profiles.work = {
      settings = {
        "full-screen-api.ignore-widgets" = true;
      };
      userChrome = "";
      isDefault = true;
    };
    
    profiles.school = {
      settings = {
        "full-screen-api.ignore-widgets" = true;
      };
      userChrome = "";
      id = 1;
    };
  };

  programs.zen-browser = {
    enable = true;
    nativeMessagingHosts = [pkgs.firefoxpwa];
    policies = {
      DisableAppUpdate = true;
      DisableTelemetry = true;
    };
  };

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    Unit = {
      Description = "polkit-gnome-authentication-agent 1";
      Wants = [ "graphical-session.target" ];
    After = [ "graphical-session.target" ];
  };
  Install = {
    WantedBy = [ "graphical-session.target" ];
  };
  Service = {
    Type = "simple";
    ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
    Restart = "on-failure";
    RestartSec = 1;
    TimeoutStopSec = 10;

    };
  };
}
