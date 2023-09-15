# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.fontSize = 16;

  networking = {
    hostName = "gargantuan";
    networkmanager.enable = true;
    wireless.enable = false;  # Enables wireless support via wpa_supplicant.
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure X11, desktop, and keymap
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
    
    # Desktop Environments
    desktopManager.plasma5.enable = false;
    desktopManager.gnome.enable = false;

    # Display managers
    #displayManager.sddm.enable = true;
    displayManager.gdm.enable = true;
    # displayManager.gdm.wayland = false;
    #displayManager.job.execCmd = "${pkgs.ly}/bin/ly";

    # Window Managers
  };

  programs.hyprland.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cameron = {
    isNormalUser = true;
    description = "Cameron";
    extraGroups = [ "networkmanager" "wheel" "network" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  nix.settings.trusted-users = [ "root" "cameron"];
  
  # Fonts
  fonts.fonts = with pkgs; [
    # fira-code
    # fira
    # cooper-hewitt
    # ibm-plex
    jetbrains-mono
    # iosevka
    # bitmap
    # spleen
    # fira-code-symbols
    # powerline-fonts
    nerdfonts
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # zsh
    # tigervnc
    # thunderbird
    # parsec-bin

    # desktop environment
    wofi
    waybar
    hyprpaper
    hyprpicker
    xwayland
    #gnome.nautilus
    xfce.thunar
    gvfs
    #nwg-look # requires unstable channel
    #ly
    dunst

    # cli
    neofetch
    btop
    htop
    autojump
    ethtool
    just
    neovim
    wget
    universal-ctags
    tree
    multitail
    fprintd
    dos2unix
    tldr
    curl
    starship
    git
    kitty
    alacritty
    wgnord
    tailscale
    tmux

    # general desktop
    krita
    libreoffice
    firefox
    megasync
    obsidian
    spotify
    vscodium
    discord
    bitwarden

    # gaming
    steam
  ];

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
  };

  services.fprintd.enable = true;

  programs.starship.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
