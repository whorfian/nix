{ pkgs, neovim, user, email }: {
  useGlobalPkgs = true;
  users."${user}" = {
    programs = {
      git = {
        enable = true;
        userName = "${user}";
        userEmail = "${email}";
        extraConfig = { init.defaultBranch = "master"; };
        aliases = {
          c = "commit -am";
          s = "status";
          a = "add .";
          i = "init";
          d = "diff";
          p = "push origin master";
        };
      };
      bash.shellAliases = {
        g = "git";
        v = "nvim";
        l = "exa -la";
        h = "gh";
        nrs = "sudo nixos-rebuild switch --flake '/home/${user}/nix#${user}'";
        gg = "g a && g c 'boop' && g p";
      };
      kitty = {
        enable = true;
        settings = {
          font_size = "18.0";
          font_family = "FiraCode Nerd Font";
          bold_font = "auto";
          italic_font = "auto";
          bold_italic_font = "auto";
          theme = "One Dark";
          # keybindings = "";
        };
      };
      neovim = {
        enable = true;
        package = neovim.packages.${pkgs.system}.default;
        extraPackages = with pkgs; [
          tree-sitter
          nodePackages.pyright
          rust-analyzer
        ];
        plugins = with pkgs.vimPlugins; [
          vim-nix
          vim-which-key
          nvim-lspconfig
          nvim-cmp
          cmp-nvim-lsp
          cmp_luasnip
          luasnip
          plenary-nvim
          telescope-nvim
          delimitMate
          nvim-treesitter
          nvim-ts-rainbow
          surround
          vim-easymotion
        ];
      };
    };
    services = {
      sxhkd = {
        enable = true;
        extraConfig = builtins.readFile sxhkd/sxhkdrc;
      };
    };
    xsession = {
      windowManager = {
        bspwm = {
          enable = true;
          extraConfig = builtins.readFile bspwm/bspwmrc;
        };
      };
    };
  };
}
