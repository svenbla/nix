_: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    # Preserve the pre-26.05 defaults explicitly.
    withPython3 = true;
    withRuby = true;
  };
}
