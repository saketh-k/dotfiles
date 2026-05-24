{ config, pkgs, lib, ... }:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.desktopManager.gnome.enable = true;
  services.logind.settings.Login = {
    IdleAction = "sleep";
    IdleActionSec = 600;
    HandlePowerKey = "suspend";
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session =
        let
          tuigreet = "${lib.getExe pkgs.tuigreet}";
          baseSessionsDir = "${config.services.displayManager.sessionData.desktops}";
          xSessions = "${baseSessionsDir}/share/xsessions";
          waylandSessions = "${baseSessionsDir}/share/wayland-sessions";
          tuigreetOptions = [
            "--remember"
            "--remember-session"
            "--sessions ${waylandSessions}:${xSessions}"
            "--time"
            "--theme 'border=magenta;text=cyan;prompt=green;action=blue;button=cyan'"
          ];
          flags = lib.concatStringsSep " " tuigreetOptions;
        in
        {
          command = "${tuigreet} ${flags}";
          user = "greeter";
        };
    };
  };

  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "journal";
    StandardError = "journal";
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };

  # Enable gnome secrets vault
  services.gnome.gnome-keyring.enable = true;

  # i18n input method
  i18n.inputMethod.type = "fcitx5";
  i18n.inputMethod.enable = true;
  i18n.inputMethod.fcitx5 = {
    addons = with pkgs; [
      fcitx5-gtk
      fcitx5-m17n
    ];
    waylandFrontend = true;
  };

  # fonts
  fonts.packages = with pkgs; [
    liberation_ttf
    fira-mono
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];

  # Configure keymap in X11
  services.xserver.xkb = {
    model = "dell";
    layout = "us";
    options = "ctrl:nocaps";
  };

  # Enable swaywm
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
  programs.niri = {
    enable = true;
  };

  # Install firefox
  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    grim
    slurp
    wl-clipboard
    libnotify
    tuigreet
    fcitx5
  ];
}
