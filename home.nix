{ a }: {
  useGlobalPkgs = true;
  users."${a.user}" = {
    programs = {
      git = {
        enable = true;
        userName = "${a.user}";
        userEmail = "${a.email}";
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
      bash = {
        enable = true;
        shellAliases = {
          g = "git";
          v = "nvim";
          l = "exa -la";
          h = "gh";
          nrs =
            "sudo nixos-rebuild switch --flake '/home/${a.user}/nix#${a.user}'";
          gg = "g a && g c 'boop' && g p";
        };
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
        package = a.neovim.packages.${a.pkgs.system}.default;
        extraPackages = with a.pkgs; [
          tree-sitter
          nodePackages.pyright
          rust-analyzer
          #nix?
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
