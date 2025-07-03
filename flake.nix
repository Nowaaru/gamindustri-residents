{
  description = "Description for the project";

  inputs = {
    flake-parts.follows = "gamindustri-utils/flake-parts";

    # test, remove after user-noire is done
    nmm-mods = {
      url = "path:/shared/modding/clients";
      inputs = {
        home-manager.follows = "gamindustri-utils/nixpkgs";
        nixpkgs.follows = "gamindustri-utils/nixpkgs";
      };
    };

    user-noire = {
      url = "path:noire";
      inputs.gamindustri.follows = "gamindustri";
      inputs.gamindustri-utils.follows = "gamindustri-utils";
      inputs.nmm-mods.follows = "nmm-mods";
    };

    gamindustri = {
      type = "indirect";
      id = "gamindustri";
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

      folded-residents = lib.attrsets.foldlAttrs (acc: _: v: acc ++ (lib.lists.singleton v)) [] all-residents;
      homeManagerEnvironment = lib.gamindustri.users.mkHomeManager folded-residents {
        inherit inputs;

        specialArgs = {
          inherit (inputs) nix-colors;
          inherit (lib) withSystem;
          # stable = lib.traceVal (builtins.attrNames args.self);
        };

        cfgRootName = "cfg";
        sysRoot = inputs.gamindustri.outPath;
        usrRoot = ./.;
      };
    in {
      imports = [
        homeManagerEnvironment
      ];

      systems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin"];

      perSystem = {
        config,
        self',
        inputs',
        pkgs,
        system,
        ...
      }: {
        # Per-system attributes can be defined here. The self' and inputs'
        # module parameters provide easy access to attributes of the same
        # system.

        # Equivalent to  inputs'.nixpkgs.legacyPackages.hello;
        packages.default = pkgs.hello;
      };

      flake.all-residents = all-residents;
      flake.folded-residents = folded-residents;
      flake.gamindustri = inputs.gamindustri;
    });
}
