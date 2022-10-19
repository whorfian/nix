{ config, lib, pkgs, user, version, ... }@a: {
  imports = [ ./hardware-configuration.nix a.home-manager.nixosModule ];

  home-manager = import ./home.nix { inherit a; };

  # TODO: try out wayland with hyprland

  sound.enable = true;
  hardware = {
    pulseaudio.enable = false;
    bluetooth.enable = true;
  };

  # TODO: remove this in favor of a rofi script 
  services.blueman.enable = true;

  fonts = {
    fonts = with pkgs;
      [ (nerdfonts.override { fonts = [ "SourceCodePro" "FiraCode" ]; }) ];
    fontconfig = {
      defaultFonts = {
        monospace = [ a.style.mono-font ];
        sansSerif = [ a.style.sans-font ];
        serif = [ a.style.serif-font ];
      };
    };
  };

  boot = {
    # kernelPackages = pkgs.linuxPackages_latest; # why crash?
    loader = {
      timeout = 5;
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      grub = {
        extraConfig = ''GRUB_CMDLINE_LINUX="video=HDMI-0:e"'';
      }; # why no work?
    };
    # Laptop shenanigans
    kernelParams = [ "module_blacklist=i915" ];
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
          #xrandr -o left
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

  users = {
    defaultUserShell = pkgs.zsh;
    users."${user}" = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" ];
    };
  };

  nixpkgs.config.allowUnfree = true;

  environment = {
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      TERMINAL = "kitty";
      SHELL = "zsh";
      PAGER = "less";
      BROWSER = "google-chrome-stable";
    };
    shells = with pkgs; [ zsh ];
    systemPackages = with pkgs; [
      (python3.withPackages (ps: with ps; [ numpy more-itertools pyserial pillow ]))
      abduco
      bat
      brightnessctl
      bspwm
      clang
      clonehero
      cmake
      stylua
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
      kitty-themes
      lua
      maim
      neofetch
      nixfmt
      nyxt
      osu-lazer
      ripgrep
      rofi
      sxhkd
      thefuck
      tldr
      vscode
      wget
      wmctrl
      xclip
      xdotool
      zsh
      mpv
      vlc
      (lutris.override { extraLibraries = pkgs: [ pkgs.libunwind ]; })
      dxvk
      vulkan-tools
      pciutils
      qmk
    ];
  };

  hardware = {
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      modesetting.enable = true;
      prime = {
        sync.enable = true;
        nvidiaBusId = "PCI:1:0:0"; # lspci VGA/3D
        intelBusId = "PCI:2:0:0"; # lspci VGA/3D
      };
      powerManagement.enable = true;
      # powerManagement.finegrained = true;
    };
    opengl.enable = true;
  };
  # specialisation = {
  #   external-display.configuration = {
  #     system.nixos.tags = [ "external-display" ];
  #     hardware.nvidia.prime.offload.enable = lib.mkForce false;
  #     hardware.nvidia.powerManagement.enable = lib.mkForce false;
  #   };
  # };
  #   services.xserver.screenSection = ''
  # Option "metamodes" "nvidia-auto-select +0+0 {ForceFullCompositionPipeline=On}"
  # Option "AllowIndirectGLXProtocol" "off"
  # Option "TripleBuffer" "on"
  #   '';

  programs = { steam.enable = true; };

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    package = pkgs.nixVersions.unstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    settings = { auto-optimise-store = true; };
  };

  system.stateVersion = "${version}";
}
