{
  config,
  pkgs,
  lib,
  ...
}:
let
  theme-color = "everforest";
in
{
  home.file.".icons/default".source = "${pkgs.posy-cursors}/share/icons/Posy_Cursor";
  home.pointerCursor = {
    package = pkgs.posy-cursors;
    name = "Posy_Cursor_Black";
    gtk.enable = true;
    x11.enable = true;
  };

  stylix = {
    enable = true;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/${theme-color}.yaml";
    autoEnable = true;

    targets = {
      yazi.colors.enable = true;
      zellij.colors.enable = true;
      gtk.colors.enable = true;
      gitui.colors.enable = true;
      tofi.colors.enable = true;
      wofi.colors.enable = true;

      starship.colors.enable = false;
      sway.enable = false;
      alacritty.fonts.enable = false;
      hyprlock.enable = false;
      spotify-player.enable = false;

      zen-browser.profileNames = [ "fixed" ];
      waybar.addCss = false;
    };

    fonts = {

      monospace = {
        name = "JetBrainsMono Nerd Font Propo";
        package = pkgs.nerd-fonts.jetbrains-mono;
      };

      sansSerif = {
        name = "Noto Sans";
        package = pkgs.noto-fonts;
      };

      serif = {
        name = "Noto Serif";
        package = pkgs.noto-fonts;
      };

      emoji = {
        name = "Noto Emoji";
        package = pkgs.noto-fonts-monochrome-emoji;
      };

    };
  };

  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    nerd-fonts.caskaydia-cove
    nerd-fonts.caskaydia-mono
    base16-schemes
    posy-cursors
  ];
}
