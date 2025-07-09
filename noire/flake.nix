{
  description = "Description for the project";

  inputs = {
    # Flake Setup
    nixpkgs.follows = "gamindustri-utils/nixpkgs";
    home-manager.follows = "gamindustri-utils/home-manager";

    gamindustri-utils = {
      type = "indirect";
      id = "nix-utils";
    };

    # Game Modding
    nix-mod-manager = {
      url = "github:nowaaru/nix-mod-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nmm-mods = {
      url = "path:/shared/modding/clients";
      inputs = {
        nix-mod-manager.follows = "nix-mod-manager";
        home-manager.follows = "gamindustri-utils/home-manager";
        nixpkgs.follows = "gamindustri-utils/nixpkgs";
      };
    };

    # Browsers
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Personal Things
    secrets.url = "path:/shared/secrets";
    an-anime-game-launcher.url = "github:ezKEA/aagl-gtk-on-nix";

    umu-launcher = {
      url = "github:Open-Wine-Components/umu-launcher?dir=packaging/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Productivity
    nvf.url = "github:NotAShelf/nvf/a1806457caf18e02bbf747e0263caf8740bacfb6";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    # Fun
    power-mode-nvim = {
      url = "github:nowaaru/power-mode.nvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vintagestory = {
      url = "path:/shared/flakes/vintagestory";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # KDE Plasma 6
    plasma-manager = {
      url = "github:pjones/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    plasma-theme-moe-dark = {
      url = "gitlab:jomada/moe-dark";
      flake = false;
    };

    tela-icons = {
      url = "github:vinceliuice/tela-icon-theme";
      flake = false;
    };

    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin-cursors.url = "github:catppuccin/cursors";

    # Hyprland
    # [TODO]: make sure to chunk this down over time. please.
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

    ags = {
      url = "github:Aylur/ags";
    };
  };

  outputs = {
    flake-parts,
    gamindustri-utils,
    ...
  } @ inputs: (let
    inherit (gamindustri-utils) lib;
  in
    flake-parts.lib.mkFlake {inherit inputs;} ({withSystem, ...}: {
      systems = ["x86_64-linux"];
      flake.homeUsers.noire = lib.gamindustri.users.mkUser "noire" {
        system = "x86_64-linux";
        extraSpecialArgs = {
          inherit (gamindustri-utils.legacyPackages.x86_64-linux) nur stable master;
          inherit withSystem;
        };

        sessionVariables = {
          EDITOR = "nvim";
        };
      };
    }));
}
