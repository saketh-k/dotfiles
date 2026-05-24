{
  # Define the inputs (dependencies) for your flake
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    copyparty = {
      url = "github:9001/copyparty";
    };
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    #nixos-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixmate = {
      url = "github:daskladas/nixmate";
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
  outputs =
    inputs@{
      self,
      nixpkgs,
      copyparty,
      nixos-hardware,
      nix-minecraft,
      stylix,
      home-manager,
      nixmate,
      agenix,
      zen-browser,
      ...
    }:
    let
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
        inherit system;
        config.allowUnfree = true;
        config.allowUnfreePredicate = _: true;
        overlays = [
          tofiOverlay
        ];
      };
    in
    {
      # defaultPackage.${system} = home-manager.defaultPackage.${system};
      # Define Home Manager configurations
      nixosConfigurations = {
        fw-server = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit nixpkgs;
            inherit system;
          };
          modules = [
            ./hosts/fw-server/configuration.nix
            nixos-hardware.nixosModules.framework-amd-ai-300-series
            copyparty.nixosModules.default
            nix-minecraft.nixosModules.minecraft-servers
            (
              { pkgs, ... }:
              {
                nixpkgs.overlays = [
                  copyparty.overlays.default
                  nix-minecraft.overlay
                ];
                environment.systemPackages = [
                  pkgs.copyparty
                  nixmate.packages.${system}.default
                ];
                # services.copyparty.enable = false;
              }
            )
          ];
        };
        fw-laptop = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit nixpkgs;
            inherit system;
          };
          modules = [
            ./hosts/fw-laptop/configuration.nix
            nixos-hardware.nixosModules.framework-amd-ai-300-series
            copyparty.nixosModules.default
            nix-minecraft.nixosModules.minecraft-servers
            (
              { pkgs, ... }:
              {
                nixpkgs.overlays = [
                  copyparty.overlays.default
                  nix-minecraft.overlay
                ];
                environment.systemPackages = [
                  pkgs.copyparty
                  nixmate.packages.${system}.default
                ];
                # services.copyparty.enable = false;
              }
            )
          ];
        };
      };
      homeConfigurations = {
        saketh = home-manager.lib.homeManagerConfiguration {
          # Define the Home Manager environment
          pkgs = pkgs;
          extraSpecialArgs = { inherit zen-browser; };
          # Home Manager modules
          modules = [
            zen-browser.homeModules.beta
            agenix.homeManagerModules.default
            stylix.homeModules.stylix
            ./modules/home/core.nix
            ./modules/home/themeing
            ./modules/home/sway
            ./modules/home/term
            ./modules/home/desktop_apps
            ./modules/home/browsers
            ./modules/home/design
          ];
        };
      };
    };

}
