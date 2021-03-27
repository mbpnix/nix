# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  stable = import (<stable>) { 
    config.allowUnfree = true;
  };
in

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./fstrim.nix
      ./fonts.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "Europe/Bucharest";

  # NetworkManager
  networking.networkmanager.enable = true;

  # Intel Microcode
  hardware.cpu.intel.updateMicrocode = true;

  # Allow Unfree
  nixpkgs.config.allowUnfree = true;

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp8s0.useDHCP = true;
  networking.interfaces.wlp9s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "uk";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;


  # Enable Desktop Environment.
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.displayManager.lightdm = {
    enable = true;
    greeters.tiny = {
      enable = true;
      extraConfig = let
        black = import (builtins.fetchTarball {
          url = "https://github.com/mbpnix/nixos-black-theme/releases/download/v1.1.1/nixos-black-theme-1.1.1.tar.gz";
          sha256 = "1l8kyr83q3lwpp6hpia49zj9cyjbkplrsk8qyxwkpi8491ay87v6";
        });
      in
        black.lightdm-tiny;
    };
  };

  # By Me.
  
  nix = {
   package = pkgs.nixFlakes;
   extraOptions = ''
     experimental-features = nix-command flakes
   '';
  };
  
  services.xserver.displayManager.defaultSession = "xfce";
  

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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.master = {
    isNormalUser = true;
    description = "Master";
    initialPassword = "password";
    extraGroups = [ "wheel" "networkmanager" "audio" "video" ]; # Enable ‘sudo’ for the user.
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget vim git
    firefox
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 ];
  networking.firewall.allowedUDPPorts = [ 22 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?

  # Bash Completion.
  programs.bash.enableCompletion = true;
  
  # Video Drivers.
  services.xserver.videoDrivers = [ "intel" "ati" "amdgpu" ];
  
  # Keychain.
  security.pam.services.lightdm.enableGnomeKeyring = true;
  services.gnome3.gnome-keyring.enable = true;
  programs.seahorse.enable = true;

}

