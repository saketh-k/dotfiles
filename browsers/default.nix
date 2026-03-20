{
  lib,
  config,
  pkgs,
  zen-browser,
  ...
}:

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
    nativeMessagingHosts = [ pkgs.firefoxpwa ];
    policies = import ./zen-policies.nix;
    profiles.fixed = {
      search = import ./zen-search-settings.nix { inherit pkgs; };
      settings = {
        "full-screen-api.ignore-widgets" = true;
        "widget.dmabuf.force-enabled" = true;
        "zen.workspaces.continue-where-left-off" = true;
        "zen.workspaces.natural-scroll" = true;
        "zen.view.compact.hide-tabbar" = true;
        "zen.view.compact.hide-toolbar" = true;
        "zen.view.compact.animate-sidebar" = false;
        "zen.welcome-screen.seen" = true;
        "zen.urlbar.behavior" = "float";
      };
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

  xdg.mimeApps =
    let
      value =
        let
          zen-browser = config.inputs.zen-browser.packages.${config.system}.beta; # or twilight
        in
        zen-browser.meta.desktopFileName;

      associations = builtins.listToAttrs (
        map
          (name: {
            inherit name value;
          })
          [
            "application/x-extension-shtml"
            "application/x-extension-xhtml"
            "application/x-extension-html"
            "application/x-extension-xht"
            "application/x-extension-htm"
            "x-scheme-handler/unknown"
            "x-scheme-handler/mailto"
            "x-scheme-handler/chrome"
            "x-scheme-handler/about"
            "x-scheme-handler/https"
            "x-scheme-handler/http"
            "application/xhtml+xml"
            "application/json"
            "text/plain"
            "text/html"
          ]
      );
    in
    {
      associations.added = associations;
      defaultApplications = associations;
    };
}
