{config,pkgs,...}:
{
  fonts.fontconfig.enable=true;
  home.packages = with pkgs; [
    jetbrains-mono
    fira-code
    #(nerd-fonts.override {fonts = ["CascadiaCode" "FiraCode" "FiraMono"]; } )
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-mono
    nerd-fonts.caskaydia-cove
    nerd-fonts.caskaydia-mono

    noto-fonts

    #dejavu_fonts
    #cascadia-code
  ];
}
