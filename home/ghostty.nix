{
  lib,
  pkgs,
  ...
}: {
  programs.ghostty = {
    enable = true;
    package =
      if pkgs.stdenv.hostPlatform.isDarwin
      then pkgs.ghostty-bin
      else pkgs.ghostty;

    enableZshIntegration = true;

    settings = {
      cursor-style = "block";
      cursor-style-blink = false;
      cursor-invert-fg-bg = false;
      shell-integration-features = "no-cursor";
      theme = "Catppuccin Mocha";
      mouse-hide-while-typing = true;

      quit-after-last-window-closed = true;
      confirm-close-surface = false;
      app-notifications = false;
      desktop-notifications = false;
    };
  };
}
