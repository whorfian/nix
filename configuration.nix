{ config, lib, pkgs, home-manager, neovim, ... }:
let
  user = "whorf";
  email = "whorf@whorf.dev";
  version = "22.05";
in {
  imports = [ ./hardware-configuration.nix home-manager.nixosModule ];

  # Is this stupid or isn't it? I'm confused. 
  home-manager = import ./home.nix { inherit pkgs neovim user email; };

  sound.enable = true;
  hardware.pulseaudio.enable = false;

  boot = {
    # kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      timeout = 2;
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      grub = { extraConfig = ''GRUB_CMDLINE_LINUX="video=HDMI-0:e"''; };
    };
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.utf8";

  services = {
    picom.enable = true;
    printing.enable = true;
    logind.lidSwitch = "ignore";
    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
      layout = "us";
      xkbVariant = "";
      libinput.enable = true;
      windowManager = { bspwm = { enable = true; }; };
      desktopManager = { xterm.enable = false; };
      displayManager = {
        defaultSession = "none+bspwm";
        sessionCommands = ''
          xrandr -o left
          xrandr --output HDMI-0 --mode 2560x1440 --rate 144.0
        '';
        autoLogin = {
          enable = true;
          user = "${user}";
        };
      };
    };
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
      BROWSER = "google-chrome-stable";
      # CHROMIUM_FLAGS="$CHROMIUM_FLAGS --no-default-browser-check";
    };
    systemPackages = with pkgs; [
      (python3.withPackages (ps: with ps; [ numpy more-itertools ]))
      abduco
      bat
      brightnessctl
      bspwm
      clang
      clonehero
      cmake
      coreutils
      direnv
      discord
      dmenu
      dunst
      dvtm
      exa
      fd
      feh
      file
      fish
      fzf
      gh
      git
      google-chrome
      gotop
      jq
      killall
      kitty
      maim
      neofetch
      nixfmt
      nyxt
      osu-lazer
      ripgrep
      rofi
      sxhkd
      tldr
      vscode
      wget
      wmctrl
      xclip
      xdotool
      zsh
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
