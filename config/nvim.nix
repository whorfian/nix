{ a }: {
  enable = true;
  package = a.neovim.packages.${a.pkgs.system}.default;
  extraConfig = "luafile ~/.config/nvim/config.lua";
  extraPackages = with a.pkgs; [
    tree-sitter
    nodePackages.pyright
    rust-analyzer
  ];
  plugins = with a.pkgs.vimPlugins; [

    # 
    nvim-lspconfig

    # 
    nvim-treesitter

    # 
    telescope-nvim

    # COMPLETION
    nvim-cmp
    cmp-buffer
    cmp-path
    cmp-commandline
    cmp-nvim-lsp
    cmp_luasnip

    # SNIPPETS
    luasnip
    friendly-snippets

    # 
    surround

    # 
    vim-easymotion

    # 
    which-key-nvim

    #
    nvim-ts-rainbow

    # THEME
    onedark-nvim

    # UTILITY
    plenary-nvim

    # LANGUAGES
    vim-nix

    # FORMATTING

    # delimitMate
    # telescope-file-browser-nvim
    # gitsigns-nvim
    # neogit
  ];
}


# idea: gd(?) in vim on vimPlugins takes me to the github page