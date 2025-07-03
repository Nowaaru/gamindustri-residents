args @ {
  lib,
  inputs,
  ...
}: let
  usrRoot = ./.;

  specialArgs = {
    inherit (args.self.legacyPackages.x86_64-linux) stable;
    inherit (args) inputs nur modules;
    inherit (inputs) nix-colors;
    inherit (lib) withSystem;
    # stable = lib.traceVal (builtins.attrNames args.self);
  };
in
  with (lib.gamindustri.users); (mkHomeManager [
    # me!
    (mkUser "noire" {
      system = "x86_64-linux";

      modules = [
        inputs.gamindustri-utils.homeModules.plasma
      ];

      extraSpecialArgs = {
        inherit (args.self.legacyPackages.x86_64-linux) stable master;
      };
      sessionVariables = {
        EDITOR = "nvim";
      };
    })

    (mkUser "blanc" {
      system = "aarch64-linux";
      sessionVariables = {
        EDITOR = "nvim";
      };
    })

    (mkUser "sm1l3y4l" {
      system = "x86_64-linux";
      sessionVariables = {
        EDITOR = "nvim";
      };

      extraSpecialArgs.stable = args.self.legacyPackages.x86_64-linux.stable;
    })

    # (mkUser "vert" {
    #   system = "x86_64-linux";
    #   sessionVariables = {
    #     EDITOR = "nvim";
    #   };
    # })
  ] {inherit usrRoot specialArgs;})
