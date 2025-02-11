{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: 

{
  imports = [
    ./bufferline.nix
    ./lsp.nix
    #inputs.nixpkgs
  ];
    colorschemes = {
      tokyonight = {
        enable = true;
        settings = {
          style = "night";
          transparent = false;
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
      jupytext.enable = true;
      magma-nvim.enable = true;
      harpoon = {
	enable = true;
	enableTelescope = true;
      };
      nvim-snippets.enable = true;
      tmux-navigator.enable = true;
      nix.enable = true;
      which-key.enable = true;
    };

}
