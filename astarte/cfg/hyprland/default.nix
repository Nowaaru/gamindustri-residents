{
  pkgs,
  inputs,
  lib,
  ...
}: let
  mode = "dark";
  theme =
    (import (inputs.gamindustri-utils.outPath + "/cfg/themes") {
      inherit (inputs) nix-colors;
      inherit pkgs;
      kind = mode;
    })
    .mountain-view;

  startup-items = lib.mkMerge (lib.attrsets.foldlAttrs (acc: k: v: acc ++ (lib.singleton (import ./startup/${k}))) [  ] (builtins.readDir ./startup));

  ###############################################

  workspaces = import ./workspaces.nix;
  bindings = import ./bindings.nix {
    inherit pkgs theme;
  };
  monitors = import ./monitors.nix;
  tearing = import ./tearing.nix;
  util = import ./util.nix {inherit pkgs lib;};
  vars = import ./vars.nix {
    inherit theme pkgs;
  };
in 
{
  inherit theme;
  hypr = lib.mkMerge 
      [
        startup-items
        tearing
        monitors
        bindings
        workspaces
        vars
        {
          # inherit (vars) input general decoration animations debug;
          # inherit (workspaces) workspace;
          # inherit (bindings) bind bindm;
          # inherit (monitors) monitor;

          # Some default env vars.
          env =
            [
              "XCURSOR_SIZE,24"
            ];

          windowrulev2 =
          [
              # Example windowrule v1
              # windowrule = float, ^(kitty)$

              # Example windowrule v2
              # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$

              # "nomaximizerequest, class:(.*)"  You'll probably like this.

              # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
          ];

          layerrule = [
            "blur, eww-blur"
            "ignorealpha 0.3, eww-blur"
          ];

          # Stuff to run every reload.
          exec = [
            # "eww open-many -c ~/.config/eww topbar sidebarf"
            (util.str.applySwayTheme theme)
          ];
        }
      ];
}

