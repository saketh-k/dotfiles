{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: 

{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    inputs.nixpkgs
  ];
  inputs.nixpkgs.config.allowUnfreePredicate = _ : true;
  inputs.nixpkgs.config.allowUnfree= true;
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    colorschemes = {
      tokyonight = {
        enable = true;
        settings = {
          style = "night";
        };
      };
    };
    opts = {
      number = true;
      relativenumber = true;

      shiftwidth = 2;
    };
    viAlias = true;
    vimAlias = true;
    plugins = {
      #copilot-vim.enable = true;
      fzf-lua.enable = true;
      telescope.enable = true;
      web-devicons.enable = true;
      harpoon = {
	enable = true;
	enableTelescope = true;
      };
      tmux-navigator.enable = true;
      nix.enable = true;
      which-key.enable = true;
    };

  };
}
