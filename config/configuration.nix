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
    picom = {
      enable = false;
      vSync = false;
      backend = "glx";
      settings = {
        refresh-rate = 0;
        unredir-if-possible = true;
        unredir-if-possible-exclude =
          [ "class_g = 'looking-glass-client' && !focused" ];
      };
    };
    printing.enable = true;
    logind.lidSwitch = "ignore";
    xserver = {
      # testing stutter problems
      #displayManager.gdm.enable = true;
      #desktopManager.gnome.enable = true;

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
          #xrandr --output HDMI-0 --mode 2560x1440 --rate 144.0
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
      # wireplumber.enable = true;
    };
  };

  environment.gnome.excludePackages = (with pkgs; [ gnome-photos gnome-tour ])
    ++ (with pkgs.gnome; [
      cheese # webcam tool
      gnome-music
      gnome-terminal
      gedit # text editor
      epiphany # web browser
      geary # email reader
      evince # document viewer
      gnome-characters
      totem # video player
      tali # poker game
      iagno # go game
      hitori # sudoku game
      atomix # puzzle game
    ]);

  security = {
    rtkit.enable = true;
    sudo.wheelNeedsPassword = false;
  };

  # virtualbox
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "${user}" ];
  virtualisation.virtualbox.host.enableExtensionPack = true;

  users = {
    defaultUserShell = pkgs.zsh;
    users."${user}" = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" ];
    };
  };

  nixpkgs.config.allowUnfree = true;

  # hwo to use ge on lutris???
  services.flatpak.enable = true;
  xdg.portal.enable = true; # ?????
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ]; # ???
  # flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  # flatpak install com.valvesoftware.Steam.CompatibilityTool.Proton-GE

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
      (python3.withPackages
        (ps: with ps; [ numpy more-itertools pyserial pillow ]))
      abduco
      bat
      brightnessctl
      # protonup #update plox
      bspwm
      clang
      clonehero
      cmake
      stylua
      coreutils
      direnv
      spotify
      obs-studio
      ffmpeg
      unzip
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
      zoxide
      zellij
      nushell
      gh
      helix
      pavucontrol
      mangohud
      gamemode
      # wireplumber
      git
      google-chrome
      firefox
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
