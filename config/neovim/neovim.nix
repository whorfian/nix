{ a }: {
  enable = true;
  package = a.neovim.packages.${a.pkgs.system}.default;
  extraPackages = with a.pkgs; [
    tree-sitter
    nodePackages.pyright
    rust-analyzer
  ];
  plugins = with a.pkgs.vimPlugins; [
    # ESSENTIAL
    nvim-lspconfig
    nvim-treesitter

    # 1
    plenary-nvim
    telescope-nvim

    # 2
    nvim-cmp
    luasnip
    cmp-nvim-lsp
    cmp_luasnip

    # 3
    surround
    vim-easymotion
    vim-which-key

    # ?
    vim-nix
    delimitMate
    nvim-ts-rainbow
  ];
}
