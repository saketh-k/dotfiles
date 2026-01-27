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
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  # Define the outputs of the flake
  outputs = inputs @ {
    self,
    nixpkgs,
    #nixos-unstable,
    stylix,
    home-manager,
    agenix,
    zen-browser,
    ...
  }: let
    # Specify the system architecture (make sure this matches your platform)
    system = "x86_64-linux";
    tofiOverlay = final: prev: {
        # Fixes niri spacing bug since repo is abandoned :-(
        tofi = prev.tofi.overrideAttrs (old: {
        src = prev.fetchFromGitHub {
          owner = "philj56";
          repo = "tofi";
          rev = "refs/pull/189/head";
          sha256 = "sha256-KiSkb8HOzBnPyzQcHTyUmVixwpls3/o9BbDBkNWu71c=";
        };
      });
      };
    pkgs = import nixpkgs { 
        inherit system ;
        config.allowUnfree = true;
        config.allowUnfreePredicate = _: true;
        overlays = [
          tofiOverlay
        ];
      };
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
          # {
            # Use the Alacritty theme
            # home.packages = [
              # (inputs.zen-browser.packages.${system}.twilight-unwrapped.override {
              #     policies.DisableAppUpdate = false;
              #     #nativeMessagingHosts = [pkgs.firefoxpwa];
              #   })
              # Be sure to change full-screen-api.ignore-widgets to true
              # ];}
          zen-browser.homeModules.beta
          agenix.homeManagerModules.default
          stylix.homeModules.stylix
          ./home.nix # Path to your actual configuratin file
          ./themeing
          ./sway
          ./extras.nix
          ./term
          ./latex
          ./desktop_apps
          ./browsers
          ./design
            ];
          };
      };
    };

  }

