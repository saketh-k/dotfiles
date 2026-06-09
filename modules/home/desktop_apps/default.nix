{
  config,
  pkgs,
  lib,
  ...
}:
{
  home.packages = with pkgs; [
    vscode
    moonlight-qt
    sioyek
    chromium
    ghostty
    zotero
    bottom
    mpv
    fzf
    dmenu
    wol
    vlc
    sdrpp
    grayjay
    zmk-studio
    thunderbird-latest
    kdePackages.kdenlive
  ];
  xdg.mimeApps.enable = false;
  xdg.mimeApps.defaultApplications = {
    "application/pdf" = [ "sioyek.desktop" ];
  };

  programs.spotify-player.enable = true;

  services.easyeffects.enable = true;
  xdg.configFile."easyeffects/output/fw13-easy-effects.json" = {
    source =
      pkgs.fetchFromGitHub {
        owner = "FrameworkComputer";
        repo = "linux-docs";
        rev = "e5289ecc283e0e940536ce48e0ed789adf0280be";
        sha256 = "sha256-BRzJuc+DYJik+HmpMsRZktdwSfoLgwF2fDfwkDvl6NA=";
      }
      + "/easy-effects/fw13-easy-effects.json";
  };
  services.easyeffects.preset = "fw13-easy-effects";

  # TODO: Fix redshift.service on framework laptop
  services.gammastep = {
    enable = true;
    provider = "manual";
    latitude = 33.6;
    longitude = -117.0;
    settings = {
      general = {
        fade = 1;
        adjustment-method = "wayland";
        brightness-day = 1.0;
        brightness-night = 0.85;
        temp-night = lib.mkForce 3300;
        temp-day = lib.mkForce 5700;
      };
    };
  };
}
