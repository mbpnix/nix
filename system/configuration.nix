# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./fstrim.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "Europe/Bucharest";

  # Enable microcode updates
  hardware.cpu.intel.updateMicrocode = true;

  # NetworkManager
  networking.networkmanager.enable = true;

  # Enable non-free pkgs
  nixpkgs.config.allowUnfree = true;

  # Video Drivers
  services.xserver.videoDrivers = [ "intel" "ati" "amdgpu" ];

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp8s0.useDHCP = true;
  networking.interfaces.wlp9s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  services.xserver.exportConfiguration = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "uk";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Plasma 5 Desktop Environment
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  services.xserver.layout = "gb";
  services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  programs.bash.enableCompletion = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.master = {
    isNormalUser = true;
    initialPassword = "master";
    description = "Master";
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "sddm" ]; # Enable ‘sudo’ for the user.
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    ark
#    alacritty
    brave
    coreutils
    curl
    emacs
    firefox
    git
    git-crypt
    gnupg
    htop
    nano
    networkmanagerapplet
    p7zip
    pass
    psmisc
    rclone
    rsync
    sddm-kcm
    tree
    unzip
    utillinux
    vim
    wget
    xfontsel
    yakuake
    zip
  ] ++ (with pkgs.kdeApplications; [
    kate
  ]);

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      fantasque-sans-mono
      fira-code
      fira-mono 
      iosevka
      powerline-fonts
    ];
  };

  # Clear system
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

#  # Alacritty
#  programs.alacritty = {
#    enable = true;
#    settings = {
#      window.dynamic_padding = false;
#      window.padding = {
#        x = 0;
#        y = 0;
#      };
#      scrolling.history = 10000;
#      font = let font = "Iosevka";
#      in {
#        normal.family = font;
#        bold.family = font;
#        italic.family = font;
#        size = 11.0;
#      };
#      draw_bold_text_with_bright_colors = true;
#      colors = {
#        primary = {
#          background = "0x16161c";
#          foreground = "0xfdf0ed";
#        };
#        normal = {
#          black = "0x232530";
#          red = "0xe95678";
#          green = "0x29d398";
#          yellow = "0xfab795";
#          blue = "0x26bbd9";
#          magenta = "0xee64ae";
#          cyan = "0x59e3e3";
#          white = "0xfadad1";
#        };
#        bright = {
#          black = "0x2e303e";
#          red = "0xec6a88";
#          green = "0x3fdaa4";
#          yellow = "0xfbc3a7";
#          blue = "0x3fc6de";
#          magenta = "0xf075b7";
#          cyan = "0x6be6e6";
#          white = "0xfdf0ed";
#        };
#      };
#      background_opacity = 0.8;
#      live_config_reload = true;
#    };
#  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

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
  system.stateVersion = "20.09"; # Did you read the comment?

}

