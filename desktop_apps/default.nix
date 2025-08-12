{
  config,
  pkgs,
  zen-browser,
  ...
}:
{
  imports = [
  ./default_apps.nix
    ];

  home.file.".local/share/applications/personal-zen.desktop".text = ''
  [Desktop Entry]
  Version=1.0
  Type=Application
  Name=Personal Zen Profile
  Exec=${zen-browser.packages."x86_64-linux".twilight-unwrapped}/bin/zen -P Personal
  Terminal=false
  '';
home.file.".local/share/applications/school-zen.desktop".text = ''
  [Desktop Entry]
  Version=1.0
  Type=Application
  Name=School Zen Profile
  Exec=${zen-browser.packages."x86_64-linux".twilight-unwrapped}/bin/zen -P School
  Terminal=false
  '';
  # home.file.".local/share/applications/wolfram.desktop".text = ''
  # [Desktop Entry]
  # Version=1.0
  # Type=Application
  # Name= Wolfram Notebook
  # Exec=${pkgs.mathematica}/bin/wolframnb
  # Terminal=false
  # '';
  #
  home.packages = with pkgs; [
	#    (pkgs.obsidian.overrideAttrs (prevAttrs: rec {
	#                desktopItem= (prevAttrs.desktopItem.override (d: {exec="${pkgs.obsidian}/bin/obsidian --ozone-platform-hint=auto";}));
	# 	installPhase = builtins.replaceStrings ["${prevAttrs.desktopItem}"] ["${desktopItem}"] prevAttrs.installPhase;
	# 	}
	# ))
    
    (pkgs.discord.overrideAttrs (prevAttrs: rec {
                desktopItem= (prevAttrs.desktopItem.override (d: {exec="${pkgs.discord}/bin/discord --ozone-platform-hint=auto";}));
		installPhase = builtins.replaceStrings ["${prevAttrs.desktopItem}"] ["${desktopItem}"] prevAttrs.installPhase;
		}
	))
    pkgs.vscode
    ];

  
}
