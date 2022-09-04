{ config, lib, pkgs, home-manager, ... }: {
  imports = [ ./hardware-configuration.nix home-manager.nixosModule ];

  # home-manager = ./home.nix; # how?
  home-manager = {
    useGlobalPkgs = true;
    users.whorf = {
      programs = {
        git = {
          enable = true;
          userName = "whorf";
          userEmail = "whorf@whorf.dev";
          extraConfig = { init.defaultBranch = "master"; };
          aliases = {
            c = "commit -am";
            s = "status";
            a = "add .";
            i = "init";
            p = "push origin master";
          };
        };
      };
    };
  };

  programs.bash.shellAliases = {
    g = "git";
    v = "nvim";
    l = "exa -la";
    nrs = "sudo nixos-rebuild switch --flake '/home/whorf/nix#whorf'";
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
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      layout = "us";
      xkbVariant = "";
      libinput.enable = true; # touchpad if not using desktopManager
      displayManager = {
        autoLogin = {
          enable = true;
          user = "whorf";
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
  systemd.services = {
    # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
    "getty@tty1".enable = false;
    "autovt@tty1".enable = false;
  };

  security = {
    rtkit.enable = true;
    sudo.wheelNeedsPassword = false;
  };

  users.users.whorf = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
  };

  nixpkgs.config.allowUnfree = true;

  environment = {
    variables = {
      EDITOR = "nvim";
      TERMINAL = "kitty";
    };
    systemPackages = with pkgs; [
      nixfmt
      vim
      neovim
      emacs
      vscode
      google-chrome
      alacritty
      neofetch
      (python3.withPackages (ps: with ps; [ numpy more-itertools ]))
      wget
      discord
      gnome.gnome-tweaks
      clang
      coreutils
      git
      ripgrep
      fd
      fish
      zsh
      fzf
      rofi
      bspwm
      sxhkd
      cmake
      jq
      maim
      feh
      xclip
      bat
      nyxt
      direnv
      gh
      osu-lazer
      clonehero
      kitty
      tldr
      exa
      abduco
      dvtm
      gotop
    ];
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
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

  system.stateVersion = "22.05";
}
