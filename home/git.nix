{ pkgs, ... }:
let
  opSshSignProgram =
    if pkgs.stdenv.isDarwin
    then "/Applications/1Password.app/Contents/MacOS/op-ssh-sign"
    else "${pkgs._1password-gui}/bin/op-ssh-sign";
in
{
  programs.git = {
    enable = true;

    lfs.enable = true;

    settings = {
      user = {
        name = "svenbla";
        email = "svenblahowsky@gmail.com";
        # Public key
        signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMAd9DXw7sdlK426DKVn7ohiXtchtUKTTFmO3wKytuag";
      };

      core.autocrlf = "input";

      push.autoSetupRemote = true;
      init.defaultBranch = "main";
      rebase.autoStash = true;
      branch.autoSetupRebase = "always";

      gpg = {
        format = "ssh";
        ssh.program = opSshSignProgram;
      };

      commit.gpgsign = true;
      tag.gpgSign = true;
    };
  };
}
