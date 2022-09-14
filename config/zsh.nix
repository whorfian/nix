{ a }: {
  enable = true;
  autocd = true;
  enableAutosuggestions = true;
  enableCompletion = true;
  defaultKeymap = "viins";
  shellAliases = {
    g = "git";
    v = "nvim";
    l = "exa -la";
    h = "gh";
    nrs = "sudo nixos-rebuild switch --flake '/home/${a.user}/nix#${a.user}'";
    gg = "g a && g c 'boop' && g p";
  };
  oh-my-zsh = {
    enable = true;
    theme = "robbyrussell";
    plugins =
      [ "vi-mode" "thefuck" "command-not-found" "git" "history" "sudo" ];
  };
  initExtra = ''
    bindkey '^ ' autosuggest-accept
  '';
}
