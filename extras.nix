{lib, config, pkgs, pkgs-unstable,...}:

{
  programs.bash.enable=true;
  programs.bash.initExtra = "alias fp=\"firefox -P\""; programs.spotify-player.enable = true;
  
  programs.autojump = {
	enable = true;
	enableBashIntegration = true;
  };
  
  programs.ssh = {
	enable = true;
	addKeysToAgent = "yes";
	matchBlocks = {
		"rel" = {
			host = "rel";
			hostname = "robotecologymain.ts.saketh.dev";
			user = "robotecologymain";
			forwardAgent = true;
			forwardX11 = true;
			forwardX11Trusted = true;
		};
		"ubnt_home" = {
			host = "ubnt_home";
			hostname = "100.94.160.151";
			user = "saketh";
		};
		"uci_hpc" = {
			host = "uci_hpc";
			hostname = "hpc3.rcic.uci.edu";
			port = 6000;
			user = "skarumur";
		};
	};
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
  };

  home.file.".config/starship.toml".text = ''
    format = """
    [░▒▓](#a3aed2)\
    [  ](bg:#a3aed2 fg:#090c0c)\
    [](bg:#769ff0 fg:#a3aed2)\
    $directory\
    [](fg:#769ff0 bg:#394260)\
    $git_branch\
    $git_status\
    [](fg:#394260 bg:#212736)\
    $nodejs\
    $rust\
    $golang\
    $php\
    [](fg:#212736 bg:#1d2230)\
    $time\
    [ ](fg:#1d2230)\
    $cmd_duration\
    \n$character"""
    
    [directory]
    style = "fg:#e3e5e5 bg:#769ff0"
    format = "[ $path ]($style)"
    truncation_length = 3
    truncation_symbol = "…/"
    
    [directory.substitutions]
    "Documents" = "󰈙 "
    "Downloads" = " "
    "Music" = " "
    "Pictures" = " "
    "Development" = " "
    "dotfiles" = " "
    
    [git_branch]
    symbol = ""
    style = "bg:#394260"
    format = '[[ $symbol $branch ](fg:#769ff0 bg:#394260)]($style)'
    
    [git_status]
    style = "bg:#394260"
    format = '[[($all_status$ahead_behind )](fg:#769ff0 bg:#394260)]($style)'
    
    [nodejs]
    symbol = ""
    style = "bg:#212736"
    format = '[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)'
    
    [rust]
    symbol = ""
    style = "bg:#212736"
    format = '[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)'
    
    [golang]
    symbol = ""
    style = "bg:#212736"
    format = '[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)'
    
    [php]
    symbol = ""
    style = "bg:#212736"
    format = '[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)'
    
    [time]
    disabled = false
    time_format = "%R" # Hour:Minute Format
    style = "bg:#1d2230"
    format = '[[  $time ](fg:#a0a9cb bg:#1d2230)]($style)'

    [cmd_duration]
    disabled = false
    style = 'bold yellow'
    show_notifications = true
  '';

  home.packages = with pkgs; [
    pkgs-unstable.chromium
    (pkgs.makeDesktopItem {
      name = "vscode";
      exec =
        "env -u NIXOS_OZONE_WL ${pkgs-unstable.vscode}/bin/code --ozone-platform-hint=wayland";
      desktopName = "Code";
    })
    # pkgs-unstable.discord-canary
    mathematica
    pkgs-unstable.ghostty
    thunderbird
    bottom
    htop
    fastfetch
    ytfzf
    mpv
    fzf
    dmenu
    wol
    posy-cursors
  ];

# set cursor
  home.file.".icons/default".source = "${pkgs.posy-cursors}/share/icons/Posy_Cursor";

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
