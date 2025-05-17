{
  config,
  pkgs,
  pkgs-unstable,
  zen-browser,
  ...
}:
{
  home.file.".local/share/applications/school-zen.desktop".text = ''
  [Desktop Entry]
  Version=1.0
  Type=Application
  Name=Zen (School)
  Exec=${zen-browser.packages."x86_64-linux".default}/bin/zen -P school
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
    (pkgs.obsidian.overrideAttrs (prevAttrs: rec {
                desktopItem= (prevAttrs.desktopItem.override (d: {exec="${pkgs.obsidian}/bin/obsidian --ozone-platform-hint=auto";}));
		installPhase = builtins.replaceStrings ["${prevAttrs.desktopItem}"] ["${desktopItem}"] prevAttrs.installPhase;
		}
	))
    (pkgs-unstable.discord.overrideAttrs (prevAttrs: rec {
                desktopItem= (prevAttrs.desktopItem.override (d: {exec="${pkgs-unstable.discord}/bin/discord --ozone-platform-hint=auto";}));
		installPhase = builtins.replaceStrings ["${prevAttrs.desktopItem}"] ["${desktopItem}"] prevAttrs.installPhase;
		}
	))
    pkgs-unstable.vscode
    ];

  
}
