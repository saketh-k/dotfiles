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
  ];
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
    viAlias = true;
    vimAlias = true;
    plugins = {
      copilot-vim.enable = true;
      fzf-lua.enable = true;
      telescope.enable = true;
      harpoon = {
	enable = true;
	enableTelescope = true;
      };
      tmux-navigator.enable = true;
      nix.enable = true;
      which-key.enable = true;
      #treesitter = {
      #  enable = true;
      #  settings = {
      #    auto_install=true;
      #  };
      #};

    };

  };
}
