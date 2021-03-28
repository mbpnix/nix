{ config, pkgs, ... }:

let
  stable = import (<stable>) { 
    config.allowUnfree = true;
  };
in

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "master";
  home.homeDirectory = "/home/master";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";
  
  # User Git.
  programs.git = {
    enable = true;
    signing = {
      key = "mbpnix@pm.me";
      signByDefault = true;
    };
    userEmail = "mbpnix@pm.me";
    userName = "mbpnix";
  };
  
  # User GnuPG.
  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 60;
    enableSshSupport = true;
  };
  
  # neovim
  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraConfig = "colorscheme gruvbox";
    plugins = [
      pkgs.vimPlugins.vim-nix
      pkgs.vimPlugins.gruvbox
    ];
  };
  
  # User Packages.
  home.packages = with pkgs; [
    bc
    emacs
    exa
    git
    git-crypt
    gnupg
    google-cloud-sdk
    vlc
    mkpasswd
    nano
    neofetch
    pass
    ripgrep
    qrencode
    xclip
    youtube-dl
    pulseeffects-legacy
    vimix-gtk-themes
    luna-icons
    zafiro-icons
    brave
    htop
    stable.discord
    kotatogram-desktop
    procs
    tree
    lsd
    bat
  ];
}
