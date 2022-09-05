{ config, lib, pkgs, home-manager, ... }:
let
  user = "whorf";
  email = "whorf@whorf.dev";
  version = "22.05";
in {
  imports = [ ./hardware-configuration.nix home-manager.nixosModule ];

  home-manager = import ./home.nix {
    user = user;
    email = email;
  };

  programs.bash.shellAliases = {
    g = "git";
    v = "nvim";
    l = "exa -la";
    nrs = "sudo nixos-rebuild switch --flake '/home/${user}/nix#${user}'";
  };

  sound.enable = true;
  hardware.pulseaudio.enable = false;

  boot.loader = {
    systemd-boot.enable = true;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.utf8";

  services = {
    xserver = {
      enable = true;
      layout = "us";
      xkbVariant = "";
      libinput.enable = true;
      windowManager = {
        bspwm = { enable = true; };
      };
      desktopManager = {
        xterm.enable = false;
      };
      displayManager = {
        defaultSession = "none+bspwm";
        autoLogin = {
          enable = true;
          user = "${user}";
        };
      };
    };
    printing.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
  
  security = {
    rtkit.enable = true;
    sudo.wheelNeedsPassword = false;
  };

  users.users."${user}" = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
  };

  nixpkgs.config.allowUnfree = true;

  environment = {
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      TERMINAL = "kitty";
      SHELL = "bash";
      PAGER = "less";
    };
    systemPackages = with pkgs; [
      (python3.withPackages (ps: with ps; [ numpy more-itertools ]))
      abduco
      bat
      bspwm
      clang
      clonehero
      cmake
      coreutils
      direnv
      discord
      dvtm
      exa
      fd
      feh
      fish
      fzf
      gh
      git
      gnome.gnome-tweaks
      google-chrome
      gotop
      jq
      kitty
      maim
      neofetch
      neovim
      nixfmt
      nyxt
      osu-lazer
      ripgrep
      rofi
      sxhkd
      tldr
      vscode
      wget
      xclip
      zsh
      xdotool
      dmenu
    ];
  };

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    settings = { auto-optimise-store = true; };
  };

  system.stateVersion = "${version}";
}
