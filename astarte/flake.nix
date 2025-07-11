{
  description = "Generic Hyprland user flake.";

  inputs = {
    # Flake Setup
    nixpkgs.follows = "gamindustri-utils/nixpkgs";
    home-manager.follows = "gamindustri-utils/home-manager";

    gamindustri-utils = {
      type = "indirect";
      id = "nix-utils";
    };

    # Browsers
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Personal Things
    secrets.url = "path:/shared/secrets";

    # Productivity
    nvf.url = "github:NotAShelf/nvf/a1806457caf18e02bbf747e0263caf8740bacfb6";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    # Fun
    power-mode-nvim = {
      url = "github:nowaaru/power-mode.nvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin-cursors.url = "github:catppuccin/cursors";

    # Hyprland
    nix-colors.url = "github:misterio77/nix-colors";

    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
      inputs.hyprutils.follows = "hyprutils";
    };

    hyprutils = {
      url = "github:hyprwm/hyprutils";
    };

    hyprpicker = {
      url = "github:hyprwm/hyprpicker";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        hyprutils.follows = "hyprutils";
      };
    };

    hyprcursor = {
      url = "github:hyprwm/hyprcursor";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    xdg-desktop-portal-hyprland = {
      url = "github:hyprwm/xdg-desktop-portal-hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.hyprutils.follows = "hyprutils";
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        hyprland.follows = "hyprland";
      };
    };

    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    flake-parts,
    gamindustri-utils,
    ...
  } @ inputs: (let
    inherit (gamindustri-utils) lib;
  in
    flake-parts.lib.mkFlake {inherit inputs;} ({withSystem, ...}: {
      systems = ["x86_64-linux"];
      flake.homeUsers.astarte = lib.gamindustri.users.mkUser "astarte" {
        system = "x86_64-linux";
        extraSpecialArgs = {
          inherit (gamindustri-utils.legacyPackages.x86_64-linux) nur stable master;
          inherit (inputs) nix-colors;
          inherit withSystem;
        };

        sessionVariables = {
          EDITOR = "nvim";
        };
      };
    }));
}
