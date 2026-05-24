{ config, pkgs, lib, ... }:

{
  hardware.uinput.enable = true;
  hardware.spacenavd.enable = true;

  services.kmonad = {
    enable = true;
    keyboards = {
      builtin = {
        device = "/dev/input/by-path/platform-i8042-serio-0-event-kbd";
        config = ''
          (defcfg
            input (device-file "/dev/input/by-path/platform-i8042-serio-0-event-kbd")
            output (uinput-sink "Kmonad-Builtin-KBD"
            "sleep 1 && setxkbmap -option compose:ralt")
            cmp-seq ralt ;;
            cmp-seq-delay 5 ;;
            fallthrough true
            )
            (defalias
              esc_ctl (tap-next-release esc lctl)
            )

            (defsrc
              grv  1 2 3 4 5 6 7 8 9 0 - = bspc
              tab  q w e r t y u i o p [ ] \
              caps a s d f g h j k l ; ' ret
              lsft z x c v b n m , . / rsft 
                                       pgup  up  pgdn
              lctl lmet lalt  spc ralt rctl left down
            )
            (deflayer qwerty
              grv  1    2      3      4      5      6 7 8       9      0    -    =    bspc
              tab  q    w      e      r      t      y u i       o      p    [    ]    \
              @esc_ctl a s d f g h j k  l ; ' ret
              lsft      z      x      c      v     b n m , . / rsft 
                                       pgup  up  pgdn
              lctl lmet lalt  spc bspc rctl left down
            )
        '';
      };
    };
  };

  # enable thunderbolt
  services.hardware.bolt.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  security.polkit.enable = true;

  # Fingerprint Auth
  services.fprintd = {
    enable = true;
    tod = {
      enable = true;
      driver = pkgs.libfprint-2-tod1-goodix;
    };
  };
  security.pam.services.login.fprintAuth = true;

  services.blueman.enable = true;

  # enable redshift to manage screen color
  location = {
    provider = "manual";
    latitude = 33.684;
    longitude = -117.82;
  };

  # Allow non-sudoers to edit light command
  services.udev.extraRules = ''
    KERNEL=="backlight", SUBSYSTEM=="backlight", ACTION=="add", \
    RUN+="${pkgs.coreutils}/bin/chgrp users /sys/class/backlight/amdgpu_bl1/brightness", \
    RUN+="${pkgs.coreutils}/bin/chmod 666 /sys/class/backlight/amdgpu_bl1/brightness"
  '';
  services.udev.packages = [
    pkgs.via
  ];

  # create video group for light
  users.groups.video = { };
  users.groups.input = { };

  environment.systemPackages = with pkgs; [
    pulseaudio
    brightnessctl
    xmodmap
    fprintd
    kmonad
  ];
}
