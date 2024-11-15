{lib, config, pkgs, ...}:

{
  programs.bash.enable=true;
  programs.bash.initExtra = "alias fp=\"firefox -P\"";
  programs.spotify-player.enable = true;
  programs.autojump = {
	enable = true;
	enableBashIntegration = true;
  };
  programs.zoxide = {
	enable = true;
	enableBashIntegration = true;
  };
  programs.thefuck = {
	enable = true;
	enableBashIntegration = true;
  };
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableTransience = true;
    settings = {
      add_newline=false;
    };
  };
  programs.firefox = {
    enable = true;
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
  home.packages = with pkgs; [
    discord
    bottom
    htop
    fastfetch
    # youtube-tui
    ytfzf
    mpv
    fzf
    dmenu
    wol
  ];
 # programs.neovim = {
 #   enable = true;
 #   viAlias = true;
 #   vimAlias = true;
 #   extraConfig = ''
 #     set tabstop=2 shiftwidth=2 relativenumber expandtab
 #     set colorcolumn=80
 #   '';
 #   defaultEditor = true;
 #   coc = {
 #     enable=true;
 #   };
 #   plugins = [pkgs.vimPlugins.copilot-vim];
 # };
  services.gammastep = {
    enable = false;
    provider = "manual";
    latitude = 33.6;
    longitude = -117.0;
    settings = {
      general = {
        fade = 1;
	adjustment-method="wayland";
        brightness-day = 1.0;
	brightness-night = 0.35;
	temp-night = lib.mkForce 3300;
	temp-day = lib.mkForce 5700;
      };
    };
  };
}
