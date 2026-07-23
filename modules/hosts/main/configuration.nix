{ self, inputs, ... }: {
  
  flake.nixosModules.myMachineConfiguration = { config, pkgs, inputs, ... }: {
    imports = [
      self.nixosModules.myMachineHarware
      self.nixosModules.niri
    ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "nixos"; # Define your hostname.

    networking.networkmanager.enable = true;

    time.timeZone = "Europe/Moscow";

    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
      iLC_ADDRESS = "ru_RU.UTF-8";
      LC_IDENTIFICATION = "ru_RU.UTF-8";
      LC_MEASUREMENT = "ru_RU.UTF-8";
      LC_MONETARY = "ru_RU.UTF-8";
      LC_NAME = "ru_RU.UTF-8";
      LC_NUMERIC = "ru_RU.UTF-8";
      LC_PAPER = "ru_RU.UTF-8";
      LC_TELEPHONE = "ru_RU.UTF-8";
      LC_TIME = "ru_RU.UTF-8";
    };

    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    hardware.bluetooth.enable = true;

    services.udisks2.enable = true;

    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    services.power-profiles-daemon.enable = true;

    services.upower.enable = true;

    users.users.dogychun = {
      isNormalUser = true;
      description = "dogychun";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [];
    };

    nixpkgs.config.allowUnfree = true;

    programs.hyprland = {
      enable = false;
    };

    programs.virt-manager.enable = true;
    users.groups.libvirtd.members = ["dogychun"];
    virtualisation = {
      libvirtd.enable = true;
      spiceUSBRedirection.enable = true;
    };

    services.xserver.videoDrivers = [ "nvidia" ];
    hardware = {
      graphics.enable = true;
      graphics.enable32Bit = true;
      nvidia.open = true;
      nvidia.prime = {
        sync.enable = true;
        intelBusId = "PCI:0@0:2:0";
        nvidiaBusId = "PCI:1@0:0:0";
      };
      nvidia.modesetting.enable = true;
    };

    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
    };

    programs.gamemode.enable = true;

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "niri-session";
	        user = "dogychun";
        };
      };
    };

    environment.systemPackages = with pkgs; [
      firefox
      wget
      git
      xdg-user-dirs
      brightnessctl
      hyprpicker
      xwayland-satellite
      zoom-us
      telegram-desktop
      mangohud
      pavucontrol
      kdePackages.dolphin
      vim
      prismlauncher
      mesa
      killall
      librewolf
    ];

    services.v2raya.enable = true;

    fonts.packages = with pkgs; [
      nerd-fonts.martian-mono
    ];

    system.autoUpgrade = {
      enable = true;
      allowReboot = true;
      dates = "weekly";
    };

    system.stateVersion = "25.11"; # Did you read the comment?

  };

}
