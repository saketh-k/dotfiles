{lib, config, pkgs, ...}:

{
  programs.spotify-player.enable = true;
 
  programs.autojump = {
	enable = true;
	enableBashIntegration = true;
  };
 
  programs.zoxide = {
	enable = true;
	enableBashIntegration = true;
	options = ["--cmd cd"];
  };
 
  programs.thefuck = {
	enable = true;
	enableBashIntegration = true;
  };
 
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableTransience = true;
  };

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
    vial
    via
  ];

# set cursor
  home.file.".icons/default".source = "${pkgs.posy-cursors}/share/icons/Posy_Cursor";

  #TODO: Fix redshift.service on framework laptop
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
