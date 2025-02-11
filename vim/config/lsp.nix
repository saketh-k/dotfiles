{
  plugins = {
    treesitter = {
      enable = true;
      settings.ensure_installed = [ "python"];
    };
    lsp = {
      enable = true;
      servers = {
        pylsp = {
	  enable = true;
	  settings.plugins = {
	    black.enabled = true;
	    flake8.enabled = true;
	    isort.enabled = true;
	    pyflakes.enabled = true;
	    pycodestyle.enabled = true;
	    pydocstyle.enabled = true;
	    rope.enabled = true;
	    yapf.enabled = true;
	  };
	};
      };
    };
    conform-nvim = {
      enable = true;
      settings = { formatters_by_ft.python = [ "black" ]; };
    };
    cmp = {
      enable = true;
      settings.sources = [
	{ name = "nvim_lsp"; }
	{ name = "buffer"; }
	{ name = "path"; }
      ];
    };
  };
}
