inputs: pkgs: {
  enableExtraDiagnostics = true;
  enableTreesitter = true;
  enableFormat = true;
  enableLSP = true;
  enableDAP = true;

  rust = {
    enable = true;
    lsp = {
      enable = true;
      opts = ''
        ['rust-analyzer'] = {
          cargo = {allFeature = true},
          checkOnSave = true,
          procMacro = {
            enable = true,
          },
        },
      '';
    };
    # FIXME: https://github.com/gbprod/none-ls-shellcheck.nvim
    crates = {
      enable = true;
      codeActions = true;
    };
  };

  markdown = {
    enable = true;
    extensions = {
      render-markdown-nvim.enable = true;
    };
  };

  ts = {
    enable = true;
    format.enable = true;
    extraDiagnostics.types = [];
  };

  lua = {
    enable = true;
    lsp.lazydev.enable = true;
  };

  nix = {
    enable = true;
    lsp = {
      server = "nixd";
      options = {
        # nixpkgs.expr = ''(builtins.getFlake ${pkgs.lib.escapeShellArg inputs.self}).outputs.legacyPackages.${inputs.system}.default'';
        nixos.expr = ''(builtins.getFlake ${pkgs.lib.escapeShellArg inputs.self}).nixosConfigurations.options'';
        home-manager.expr = ''(builtins.getFlake ${pkgs.lib.escapeShellArg inputs.self}).homeConfigurations.astarte.options'';
        flake-parts-debug.expr = ''(builtins.getFlake ${pkgs.lib.escapeShellArg inputs.self}).debug.options'';
        flake-parts-per-system.expr = ''(builtins.getFlake ${pkgs.lib.escapeShellArg inputs.self}).currentSystem.options'';
      };
    };
  };

  python.enable = true;

  # TODO - add this: https://github.com/gbprod/none-ls-shellcheck.nvim
  bash.enable = false;
  css.enable = true;
  nu = {
    enable = true;
    lsp = {
      enable = true;
      server = "nushell";
    };
  };
}
