{meta, ...}: {
  imports = [
    ../../modules/common
    ../../modules/darwin
  ];

  networking.hostName = meta.name;
  networking.computerName = meta.name;
  system.defaults.smb.NetBIOSName = meta.name;
  system.primaryUser = meta.username;

  users.users."${meta.username}" = {
    home = "/Users/${meta.username}";
    description = meta.username;
  };

  nix.settings.trusted-users = [meta.username];

  nixpkgs.config.permittedInsecurePackages = [
    "lima-full-1.2.2"
    "lima-additional-guestagents-1.2.2"
  ];
}
