_:
{
  nix.settings = {
    # enable flakes globally
    experimental-features = ["nix-command" "flakes"];

  };
  nixpkgs.config.allowUnfree = true;
  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
}
