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

    # 
    nvim-cmp

    # 
    luasnip

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
    # cmp-nvim-lsp
    # cmp_luasnip
    # telescope-file-browser-nvim
    # gitsigns-nvim
    # neogit
  ];
  # generatedConfigs = {
  #   lua =
  # };
}


# idea: gd(?) in vim on vimPlugins takes me to the github page