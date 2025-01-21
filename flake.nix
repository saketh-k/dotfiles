{
  # Define the inputs (dependencies) for your flake
  inputs = {
    nixvim = {
      url = "path:./vim/";
      # url = "github:nix-community/nixvim/nixos-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    nixpkgs = {
        url = "github:NixOS/nixpkgs/1dab772dd4a68a7bba5d9460685547ff8e17d899";
    };
    nixos-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-flake = {
    	url = "github:jordanisaacs/neovim-flake";
	inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:MarceColl/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # ghostty = {
    #   url = "github:ghostty-org/ghostty";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  # Define the outputs of the flake
  outputs = inputs @ {
    self,
    nixpkgs,
    nixos-unstable,
    nixvim,
    home-manager,
    neovim-flake,
    zen-browser,
    # ghostty,
    ...
  }: let
    # Specify the system architecture (make sure this matches your platform)
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system ; config.allowUnfree = true;config.allowUnfreePredicate = _: true;};
    pkgs-unstable = import nixos-unstable {inherit system; config.allowUnfree = true; };
  in {
    # Define Home Manager configurations
    homeConfigurations = {
      saketh = home-manager.lib.homeManagerConfiguration {
        # Define the Home Manager environment
        pkgs = pkgs;
	extraSpecialArgs = {inherit inputs pkgs-unstable; };
        # Home Manager modules
        modules = [
          {
            # Use the Alacritty theme
            home.packages = [
              zen-browser.packages.${system}.default
	      nixvim.packages.${system}.default

              # neovim-flake.packages.${system}.maximal
            ];
          }
          ./home.nix # Path to your actual configuratin file
          #nixvim.homeConfigurations.nixvim
        ];
      };
    };

    # Expose Neovim as a package for the system
  };
}
