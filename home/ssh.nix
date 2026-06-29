{pkgs, ...}: let
  onePasswordAgentSocket =
    if pkgs.stdenv.isDarwin
    then "~/Library/Group\\ Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    else "~/.1password/agent.sock";
in {
  xdg = {
    enable = true;
    configFile."1Password/ssh/agent.toml".text = ''
      # 1Password SSH agent key allowlist and order.
      [[ssh-keys]]
      item = "github-auth-key"

      [[ssh-keys]]
      item = "gitlab-auth-key"

      [[ssh-keys]]
      item = "git-signing-key"
    '';
  };

  programs.ssh = {
    enableDefaultConfig = false;
    enable = true;

    settings = {
      "github.com" = {
        HostName = "github.com";
        User = "git";
        IdentitiesOnly = false;
      };

      "gitlab.com" = {
        HostName = "gitlab.com";
        User = "git";
        IdentitiesOnly = false;
      };

      "*" = {
        IdentityAgent = onePasswordAgentSocket;
      };
    };
  };
}
