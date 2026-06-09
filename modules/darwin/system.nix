{pkgs, ...}:
###################################################################################
#
#  macOS's System configuration
#
#  All the configuration options are documented here:
#    https://daiderd.com/nix-darwin/manual/index.html#sec-options
#
###################################################################################
{
  system = {
    stateVersion = 5;

    activationScripts.activateSettings.text = ''
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';

    defaults = {
      menuExtraClock.Show24Hour = true;
      NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;

      CustomUserPreferences = {
        "com.google.Chrome.app.pommaclcbfghclhalboakcipcmmndhcj" = {
          NSUserKeyEquivalents = {
            "Hide Google Chat" = "@w";

            "Close Window" = "@~w";
          };
        };
      };
    };
  };

  programs.zsh.enable = true;
}
