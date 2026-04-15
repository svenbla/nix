{pkgs, ...}: {
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
    obsidian
    ripgrep
    nodejs_22
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
    jellyfin-ffmpeg
    direnv
    python312
    python312Packages.pip
    python312Packages.cmake
    pkg-config
    qemu
    dotnetCorePackages.sdk_9_0-bin
    cyberduck
    typst
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
      "deskflow/homebrew-tap"
    ];

    # `brew install`
    brews = [
      # "aria2"  # download tool
      "watchman"
    ];

    # `brew install --cask`
    casks = [
      "affinity-photo"
      "affinity-designer"
      "affinity-publisher"
      # "anydesk"
      # "affinity-photo@1"
      # "audacity "
      # "angry-ip-scanner"
      # "affinity-designer@1"
      # "binary-ninja-free"
      # "burp-suit"
      # "balenaetcher"
      "claude"
      # "chrome-remote-desktop-host"
      # "cleanmymac"
      "deskflow/homebrew-tap/deskflow"
      "docker-desktop"
      # "datagrip"
      # "figma"
      "ghostty"
      # "google-chrome"
      # "iterm2"
      # "intellij-idea"
      "karabiner-elements"
      # "maccy"
      "notion"
      # "numi"
      # "postman"
      # "qflipper"
      # "qbittorrent"
      # "rectangle"
      "slack"
      # "sonic-visualiser"
      # "sublime-text"
      # "spotify"
      # "visual-studio-code"
      # "windscribe"
      # "webstorm"
      # "wireshark"
    ];

    /*
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
