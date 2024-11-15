{
  # Define the inputs (dependencies) for your flake
  inputs = {
    alacritty-theme = {
      url = "github:alexghr/alacritty-theme.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05"; # Adjust as per your NixOS version
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-flake.url = "github:jordanisaacs/neovim-flake";
    zen-browser.url = "github:MarceColl/zen-browser-flake";
  };

  # Define the outputs of the flake
  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    neovim-flake,
    zen-browser,
    nixvim,
    alacritty-theme,
    ...
  }: let
    # Specify the system architecture (make sure this matches your platform)
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    # Define Home Manager configurations
    homeConfigurations = {
      saketh = home-manager.lib.homeManagerConfiguration {
        # Define the Home Manager environment
        pkgs = pkgs;
	extraSpecialArgs = {inherit inputs; };
        # Home Manager modules
        modules = [
          {
            # Use the Alacritty theme
            nixpkgs.overlays = [ alacritty-theme.overlays.default ];
            home.packages = [
              zen-browser.packages.${system}.default

              # neovim-flake.packages.${system}.maximal
            ];
          }
          ./home.nix # Path to your actual configuratin file
          ./vim/default.nix
        ];
      };
    };

    # Expose Neovim as a package for the system
  };
}
