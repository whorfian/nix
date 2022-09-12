My personal NixOS config using flakes. This still contains information specific to my setup (monitor, username, email, gpu, etc.), but will hopefully become more abstract over time. Until then, you can make some minor changes and just run the following to get my exact workflow:
```
git clone https://github.com/whorfian/nix.git ~/nix 
    && cd ~/nix
    && sudo nixos-rebuild switch --flake '.#whorf'
```