{pkgs, ...}: {
  nix.settings = {
    # enable flakes globally
    experimental-features = ["nix-command" "flakes"];
  };

  fonts.packages = [
    pkgs.nerdfonts
  ];

  nixpkgs.config.allowUnfree = true;
  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
}
