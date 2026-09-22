{ mulib, host, pkgs, ... }:
mulib.module {
  name = "fonts";

  options.enable = [ host.feat.gui ];

  os = {
    fonts = {
      packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-serif
        noto-fonts-cjk-sans
        noto-fonts-color-emoji

        plemoljp-nf
        hackgen-nf-font
        moralerspace-hw

        font-awesome
        material-design-icons

        sfmono-square
        sf-pro
        sf-compact
        sf-mono
        ny
      ];

      fontDir.enable = true;

      fontconfig = {
        enable = true;
        defaultFonts = {
          serif = [ "Noto Serif CJK JP" "Noto Color Emoji" ];
          sansSerif = [ "Noto Sans CJK JP" "Noto Color Emoji" ];
          monospace = [ "SF Mono Square Regular" "Noto Color Emoji" ];
          emoji = [ "Noto Color Emoji" ];
        };
      };
    };
  };
}
