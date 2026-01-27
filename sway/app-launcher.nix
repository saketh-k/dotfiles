{
  config,
  pkgs,
  lib,
  ...
}:
# Tofi configuration
{
  # xdg.configFile."tofi/config".source = config.lib.file.mkOutOfStoreSymlink /home/saketh/dotfiles/tofi/config;
  # xdg.configFile."tofi/config".source = lib.mkAfter (lib.readFile ./config);
  # must uncomment settings in programs.tofi.settings
  # and in stylix
  home.packages = with pkgs; [
    fixedsys-excelsior
  ];
  programs = {
    tofi = {
      enable = true;
      settings = {
        width = "50%";
        height = "60%";
        padding = "5%";
        outline-width=0;
        border-width=2;
        # font = "${config.stylix.fonts.sansSerif.name}";
        font-size= lib.mkForce "42";
        prompt-text=" ";
        prompt-padding = 20;
        placeholder-text = "Search...";
        hide-cursor = false;
        corner-radius = 30;
        selection-background-padding = 5;
        selection-background-corner-radius = 5;
        num-results = 6;
      };
      
    };
  };
}
