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
          ./fonts.nix
          ./extras.nix
          ./term
          ./tofi
          ./wofi
          ./games
          ./latex
          ./desktop_apps
          ./browsers
          ./design
            ];
          };
      };
    };

  }

