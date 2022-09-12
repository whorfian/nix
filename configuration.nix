{ config, lib, pkgs, home-manager, ... }:
let
  user = "whorf";
  email = "whorf@whorf.dev";
  version = "22.05";
in {
  imports = [
    ./hardware-configuration.nix
    home-manager.nixosModule
  ];

  home-manager = import ./home.nix { inherit user email; };

  programs = {
    bash.shellAliases = {
      g = "git";
      v = "nvim";
      l = "exa -la";
      nrs = "sudo nixos-rebuild switch --flake '/home/${user}/nix#${user}'";
      gg = "g a && g c 'boop' && g p";
      gurl =
        "google-chrome-stable $(git config --get remote.origin.url | cut -f 2 -d @ | tr ':' '/')";
    };
  };

  sound.enable = true;
  hardware.pulseaudio.enable = false;

  boot = {
    # kernelPackages = pkgs.linuxPackages_latest;
    # kernelParams = [
    #  "video=HDMI-0:2560x1440@144"
    # ];
    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      grub = {
        extraConfig = ''
          GRUB_CMDLINE_LINUX="video=HDMI-0:e";
        '';
      };
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

  services.xserver.displayManager.sessionCommands = ''
    xrandr -o left
    xrandr --output HDMI-0 --mode 2560x1440 --rate 144.0
  '';

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
