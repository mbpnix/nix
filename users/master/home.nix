{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

#  # Imports
#  # imports = [ ./modules/shell-environment.nix ];
#
#  # fzf
#  programs.fzf = {
#    enable = true;
#    enableBashIntegration = true;
#    defaultCommand = "rg --files --hidden";
#    changeDirWidgetOptions = [
#      "--preview 'exa --icons --git --color always -T -L 3 {} | head -200'"
#      "--exact"
#    ];
#  };

  # User Git
  programs.git = {
    enable = true;
    ignores = [ "*~" "*.swp" ];
    signing = {
      key = "EEED5550";
      signByDefault = true;
    };
    userEmail = "mbpnix@pm.me";
    userName = "mbpnix";
  };

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "master";
  home.homeDirectory = "/home/master";
  
  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 60;
    enableSshSupport = true;
  };

  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraConfig = "colorscheme gruvbox";
    plugins = [
      pkgs.vimPlugins.vim-nix
      pkgs.vimPlugins.gruvbox
    ];
  };

  home.packages = with pkgs; [
    alacritty
    bc
    bleachbit
    discord
    exa
    emacs
    fzf
    filezilla
    git
    git-crypt
    gnupg
    google-cloud-sdk
    mkpasswd
    nano
    neofetch
    pass
    tdesktop
    ripgrep
    qrencode
    vim
    vlc
    xclip
    youtube-dl
    zsh
  ];

  # Alacritty
  programs.alacritty = {
    enable = true;
    settings = {
      window.title = "Alacritty";
      window.dynamic_title = false;
      window.startup_mode = "Maximized";
      window.dynamic_padding = false;
      window.padding = {
        x = 0;
        y = 0;
      };
      scrolling.history = 10000;
      font = let font = "Iosevka";
      in {
        normal.family = font;
        bold.family = font;
        italic.family = font;
        size = 11.0;
      };
      draw_bold_text_with_bright_colors = true;
      colors = {
        primary = {
          background = "0x16161c";
          foreground = "0xfdf0ed";
        };
        normal = {
          black = "0x232530";
          red = "0xe95678";
          green = "0x29d398";
          yellow = "0xfab795";
          blue = "0x26bbd9";
          magenta = "0xee64ae";
          cyan = "0x59e3e3";
          white = "0xfadad1";
        };
        bright = {
          black = "0x2e303e";
          red = "0xec6a88";
          green = "0x3fdaa4";
          yellow = "0xfbc3a7";
          blue = "0x3fc6de";
          magenta = "0xf075b7";
          cyan = "0x6be6e6";
          white = "0xfdf0ed";
        };
      };
      background_opacity = 1.0;
      live_config_reload = true;
    };
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.03";
}
