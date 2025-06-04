{
  # Define the inputs (dependencies) for your flake
  inputs = {
    nixpkgs = {
        url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    #nixos-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Define the outputs of the flake
  outputs = inputs @ {
    self,
    nixpkgs,
    #nixos-unstable,
    home-manager,
    zen-browser,
    ...
  }: let
    # Specify the system architecture (make sure this matches your platform)
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system ; config.allowUnfree = true;config.allowUnfreePredicate = _: true;};
  in {
    defaultPackage.${system} = home-manager.defaultPackage.${system};
    # Define Home Manager configurations
    homeConfigurations = {
      saketh = home-manager.lib.homeManagerConfiguration {
        # Define the Home Manager environment
        pkgs = pkgs;
	extraSpecialArgs = {inherit zen-browser; };
        # Home Manager modules
        modules = [
          {
            # Use the Alacritty theme
            home.packages = [
              zen-browser.packages.${system}.default
              # Be sure to change full-screen-api.ignore-widgets to true
              ];}
          ./home.nix # Path to your actual configuratin file
          ./sway
          ./fonts.nix
          ./extras.nix
          ./term
          ./tofi
          ./games
          ./latex
          ./desktop_apps
          ./browsers
          ./design

  #         ({ pkgs, ... }: {
  #           nixpkgs.overlays = [
  #             (final: prev: {
  #               wezterm = prev.wezterm.overrideAttrs (old: {
  #                 patches = (old.patches or [ ]) ++ [
  #                   (final.fetchpatch {
  #                     url = "https://patch-diff.githubusercontent.com/raw/wez/wezterm/pull/6508.patch";
  #                     sha256 = "sha256-eMpg206tUw8m0Sz+3Ox7HQnejPsWp0VHVw169/Rt4do=";
  #                   })
  #                 ];
  #               });
  #             })
  #           ];
  # })
            ];
          };

          #nixvim.homeConfigurations.nixvim
      };
    };

    # Expose Neovim as a package for the system
  }

