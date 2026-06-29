{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    git
    neovim
    zed-editor
  ];
}
