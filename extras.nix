{lib, config, pkgs, ...}:

{
  programs.spotify-player.enable = true;
 
  programs.autojump = {
	enable = true;
	enableBashIntegration = true;
    enableFishIntegration = true;
  };
 
  programs.zoxide = {
	enable = true;
	enableBashIntegration = true;
	options = ["--cmd cd"];
    enableFishIntegration = true;
  };
	# Pay respects :(
	#  programs.thefuck = {
	#    enableFishIntegration = true;
	# enable = true;
	# enableBashIntegration = true;
	#  };
	#
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableTransience = true;
  };

  services.easyeffects.enable=true;
  xdg.configFile."easyeffects/output/fw13-easy-effects.json" = {
    source = pkgs.fetchFromGitHub {
      owner = "FrameworkComputer";
      repo = "linux-docs";
      rev = "e5289ecc283e0e940536ce48e0ed789adf0280be";
      sha256 = "sha256-BRzJuc+DYJik+HmpMsRZktdwSfoLgwF2fDfwkDvl6NA=";
    } + "/easy-effects/fw13-easy-effects.json";
  };
  services.easyeffects.preset="fw13-easy-effects";

  home.file.".config/starship.toml".source = config.lib.file.mkOutOfStoreSymlink /home/saketh/dotfiles/term/starship.toml;

  home.packages = with pkgs; [
    pkgs.chromium
    pkgs.ghostty
    zotero
    bottom
    fastfetch
    mpv
    fzf
    dmenu
    wol
    posy-cursors
    vlc
  ];

# set cursor
  home.file.".icons/default".source = "${pkgs.posy-cursors}/share/icons/Posy_Cursor";



  #TODO: Fix redshift.service on framework laptop
  services.gammastep = {
    enable = true;
    provider = "manual";
    latitude = 33.6;
    longitude = -117.0;
    settings = {
      general = {
        fade = 1;
        adjustment-method="wayland";
        brightness-day = 1.0;
	brightness-night = 0.85;
	temp-night = lib.mkForce 3300;
	temp-day = lib.mkForce 5700;
      };
    };
  };
}
