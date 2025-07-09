{
  description = "Description for the project";

  inputs = {
    home-manager.follows = "gamindustri-utils/home-manager";
    flake-parts.follows = "gamindustri-utils/flake-parts";

    user-noire = {
      url = "path:noire";
      inputs.gamindustri-utils.follows = "gamindustri-utils";
    };

    gamindustri-utils = {
      type = "indirect";
      id = "nix-utils";
    };
  };

  outputs = inputs @ {
    flake-parts,
    gamindustri-utils,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;}
    (let
      inherit (gamindustri-utils) lib;
      all-residents =
        lib.attrsets.foldlAttrs
        (acc: k: v:
          acc
          // (let
            userName = lib.strings.removePrefix "user-" k;
            user = v.outputs.homeUsers.${userName};
          in {
            ${userName} = user;
          })) {} (lib.attrsets.filterAttrs (k: v: lib.strings.hasPrefix "user-" k) inputs);

      homeManagerEnvironment = lib.gamindustri.users.mkHomeManager (lib.attrsets.foldlAttrs (acc: _: v: acc ++ (lib.lists.singleton v)) [] all-residents) {
        inherit inputs;

        specialArgs = {
          inherit (inputs) nix-colors;
          inherit (lib) withSystem;
          # stable = lib.traceVal (builtins.attrNames args.self);
        };

        cfgRoot = "cfg";
        usrRoot = ./.;
      };
    in {
      imports = [
        inputs.home-manager.flakeModules.home-manager
        homeManagerEnvironment
      ];

      systems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin"];

      perSystem = {pkgs, ...}: {
        # Per-system attributes can be defined here. The self' and inputs'
        # module parameters provide easy access to attributes of the same
        # system.

        # Equivalent to  inputs'.nixpkgs.legacyPackages.hello;
        packages.default = pkgs.hello;
      };

      flake = {
        inherit (homeManagerEnvironment.flake) homeConfigurations;
        flakeModules.default = {...}: {
          imports = [
            homeManagerEnvironment
          ];
        };
      };
    });
}
