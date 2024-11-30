{ pkgs, ...}: {

  ##########################################################################
  #
  #  Install all apps and packages here.
  #
  #  NOTE: Your can find all available options in:
  #    https://daiderd.com/nix-darwin/manual/index.html
  #
  # TODO Fell free to modify this file to fit your needs.
  #
  ##########################################################################

  # Install packages from nix's official package repository.
  #
  # The packages installed here are available to all users, and are reproducible across machines, and are rollbackable.
  # But on macOS, it's less stable than homebrew.
  #
  # Related Discussion: https://discourse.nixos.org/t/darwin-again/29331

  environment.systemPackages = with pkgs; [
    zoxide
    nmap
    iperf
    ookla-speedtest
    gh
    gobuster
    netcat-gnu
    neovim
    git
    eza
    starship
    nil
    alejandra
  ];
  
  homebrew = {
    enable = true;
    

    onActivation = {
      autoUpdate = false;
      # 'zap': uninstalls all formulae(and related files) not listed here.
      cleanup = "zap";
    };

    taps = [
      "homebrew/services"
    ];

    # `brew install`
    # TODO Feel free to add your favorite apps here.
    brews = [
      # "aria2"  # download tool
    ];

    # `brew install --cask`
    # TODO Feel free to add your favorite apps here.
    /*casks = [
      "google-chrome"
      "affinity-designer@1"
      "affinity-photo@1"
      "rectangle"
      "maccy"
      "karabiner-elements"
      "anydesk"
      "chrome-remote-desktop-host"
      "cleanmymac"
      "windscribe"
      "spotify"
      "iterm2"
      "wireshark"
      "visual-studio-code"
      "webstorm"
      "intellij-idea"
      "datagrip"
      "docker"
      "numi"
      "qflipper"
      "sonic-visualiser"
      "audacity "
      "angry-ip-scanner"
      "sublime-text"
      "figma"
      "qbittorrent"
      "balenaetcher"
      "postman"
      "binary-ninja-free"
      "burp-suit"
    ];
    
    masApps = {
      Xcode = 497799835;
      GoodNotes = 1444383602;
      Excel = 462058435;
      Word = 462054704;
      PowerPoint = 462062816;
      ParallelsDesktop = 1085114709;
      KeyNote = 409183694;
      WireGuard = 1451685025;
      Parcel = 639968404;
    };
    */
  };
}
