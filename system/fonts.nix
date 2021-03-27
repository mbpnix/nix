{ pkgs, ... }:

{  
  fonts = {
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    enableDefaultFonts = false;
    fonts = with pkgs; [
      fantasque-sans-mono
      fira-code
      fira-mono 
      iosevka
      powerline-fonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      terminus-nerdfont
      (nerdfonts.override { fonts = [ "Iosevka" "FiraCode" "JetBrainsMono" ]; })
    ];
    fontconfig.defaultFonts = {
      serif = [ "Noto Serif" "Noto Color Emoji" ];
      sansSerif = [ "Noto Sans" "Noto Color Emoji" ];
      monospace = [ "Iosevka" "Noto Color Emoji" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
}
