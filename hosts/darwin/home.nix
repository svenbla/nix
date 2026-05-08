{meta, ...}: {
  imports = [
    ../../home
    ../../home/darwin
  ];

  home = {
    username = meta.username;
    homeDirectory = "/Users/${meta.username}";
    stateVersion = "24.05";
  };

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = ["Hack nerd Font"];
      sansSerif = ["Hack nerd Font"];
      serif = ["Hack nerd Font"];
    };
  };

  programs.home-manager.enable = true;
}
