{config,pkgs,...}:
{
  fonts.fontconfig.enable=true;
  home.packages = with pkgs; [
    (nerdfonts.override {fonts = ["CascadiaCode" "FiraCode" "FiraMono"]; } )
    fira-code
    fira-mono
    dejavu_fonts
    cascadia-code
  ];
}
