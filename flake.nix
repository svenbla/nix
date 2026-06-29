{
  description = "nixos and macos configuration";

  # This is the standard format for flake.nix. `inputs` are the dependencies of the flake,
  # Each item in `inputs` will be passed as a parameter to the `outputs` function after being pulled and built.
  inputs = {
    # nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-26.05-darwin";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-26.05-darwin";

    darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-26.05/";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    # home-manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs dependencies.
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    # hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    # hyprland-plugins = {
    #   url = "github:hyprwm/hyperland-plugins";
    #   inputs.hyprland.follows = "hyprland";
    # };

    # elephant.url = "github:abenz1267/elephant";
    # walker = {
    #   url = "github:abenz1267/walker";
    #   inputs.elephant.follows = "elephant";
    # };

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  };

  # The `outputs` function will return all the build results of the flake.
  # A flake can have many use cases and different types of outputs,
  # parameters in `outputs` are defined in `inputs` and can be referenced by their names.
  # However, `self` is an exception, this special parameter points to the `outputs` itself (self-reference)
  # The `@` syntax here is used to alias the attribute set of the inputs's parameter, making it convenient to use inside the function.
  outputs = inputs @ {
    self,
    nixpkgs,
    darwin,
    home-manager,
    nix-homebrew,
    ...
  }: let
    systems = [
      "aarch64-darwin"
      "x86_64-linux"
    ];

    username = "svenbla";

    hosts = [
      {
        username = username;
        name = "svenbla-mbp";
        system = "darwin";
        platform = "aarch64-darwin";
      }
      {
        username = username;
        name = "svenbla-pc";
        system = "linux";
        platform = "x86_64-linux";
      }
    ];

    forAllSystems = fn: nixpkgs.lib.genAttrs systems (system: fn {pkgs = import nixpkgs {inherit system;};});

    # forLinuxHosts = host: {
    #   name = host.name;
    #   value = nixpkgs.lib.nixosSystem {
    #     specialArgs = {
    #       inherit inputs lib;
    #       meta = host;
    #     };
    #     system = host.platform;
    #     modules = [
    #       ./hosts/linux/configuration.nix
    #       home-manager.nixosModules.home-manager
    #       {
    #         home-manager.backupFileExtension = "bak";
    #         home-manager.useUserPackages = true;
    #         home-manager.users.${host.username} = import ./hosts/linux/home.nix;
    #         home-manager.extraSpecialArgs = {
    #           inherit inputs;
    #           nixlib = lib;
    #           meta = host;
    #         };
    #       }
    #     ];
    #   };
    # };

    forDarwinHosts = host: {
      name = host.name;
      value = darwin.lib.darwinSystem {
        system = host.platform;
        specialArgs = {
          inherit inputs;
          meta = host;
        };
        modules = [
          ./hosts/darwin/configuration.nix
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              enableRosetta = true;
              user = host.username;
              autoMigrate = true;
            };
          }

          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.backupFileExtension = "bak";
            home-manager.useUserPackages = true;
            home-manager.users.${host.username} = import ./hosts/darwin/home.nix;
            home-manager.extraSpecialArgs = {
              inherit inputs;
              meta = host;
            };
          }
        ];
      };
    };
  in {
    #nixosConfigurations = builtins.listToAttrs (map forLinuxHosts (builtins.filter (h: h.system == "linux") hosts));
    darwinConfigurations = builtins.listToAttrs (map forDarwinHosts (builtins.filter (h: h.system == "darwin") hosts));

    formatter = forAllSystems ({pkgs}: pkgs.alejandra);

    # darwinConfigurations."${hostname}" = darwin.lib.darwinSystem {
    #   inherit system specialArgs;
    #   modules = [
    #     ./modules/nix-core.nix
    #     ./modules/system.nix
    #     ./modules/apps.nix
    #     ./modules/host-users.nix
    #     # home manager
    #   ];
    # };
    # nix code formatter
  };
}
