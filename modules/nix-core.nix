{pkgs, ...}: {
  nix.settings = {
    # enable flakes globally
    experimental-features = ["nix-command" "flakes"];
  };

  fonts.packages = [
    pkgs.nerd-fonts.hack
  ];

  nixpkgs.config.allowUnfree = true;
}
