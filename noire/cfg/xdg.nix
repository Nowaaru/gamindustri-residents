{
  inputs,
  pkgs,
  lib,
  ...
}: 
let 
    default-web-browser = "zen.desktop";
in {
  enable = true;
  mime.enable = true;
  mimeApps = {
    enable = true;
    defaultApplications = {
      inherit default-web-browser;
      "x-scheme-handler/about" = default-web-browser;
      "x-scheme-handler/http" = default-web-browser;
      "x-scheme-handler/https" = default-web-browser;
      "x-scheme-handler/unknown" = default-web-browser;


      # apparently there's a typo in the mimeapp entry for vintagestory
      # when i checked? hmm.

      "application/vintaagestory" = "vintagestory.desktop";
      "application/vintagestory" = "vintagestory.desktop";
      "application/vintagestorymodinstall" = "vintagestory.desktop";

      "x-scheme-handler/vintagestory" = "vintagestory.desktop";
      "x-scheme-handler/vintaagestory" = "vintagestory.desktop";
      "x-scheme-handler/vintagestorymodinstall" = "vintagestory.desktop";

      "text/html" = "zen.desktop";
      "x-scheme-handler/sgdb" = ["SGDBoop.desktop" "com.steamgriddb.SGDBoop.desktop" "~/.local/share/flatpak/exports/share/applications/com.steamgriddb.SGDBoop.desktop"];
      "x-scheme-handler/discord" = "vesktop.desktop";
      "x-scheme-handler/bitwarden" = "bitwarden.desktop";
    };
  };

  userDirs = {
    enable = true;
    createDirectories = true;
  };

  portal.xdgOpenUsePortal = true;

  # desktopEntries = with lib.gamindustri.xdg; {
  #   roblox-studio-umu-launcher = let
  #     umu-home =
  #       inputs.umu-launcher.packages.x86_64-linux.umu;
  #   in
  #     mkShortcut {
  #       instance-name = "Roblox Studio - UMU Launcher";
  #       icon = "org.vinegarhq.Vinegar.studio";
  #
  #       settings = {
  #         X-Flatpak = "org.vinegarhq.Vinegar";
  #       };
  #
  #       mimeType = [
  #         "application/x-roblox-rbxl"
  #         "application/x-roblox-rbxlx"
  #         "x-scheme-handler/roblox-studio"
  #         "x-scheme-handler/roblox-studio-auth"
  #       ];
  #
  #       executable =
  #         pkgs.writeScript "roblox-studio-umu"
  #         ''
  #           #!/usr/bin/env bash
  #
  #           export GAMEID=0
  #           export PROTONPATH="$HOME/.local/share/Steam/compatibilitytools.d/UMU-Proton-9.0-3.2/"
  #           export WINEPREFIX="$HOME/.var/app/org.vinegarhq.Vinegar/data/vinegar/prefixes/studio"
  #
  #           ${umu-home}/bin/umu-run "$(find "$HOME"/.var/app/org.vinegarhq.Vinegar/data/vinegar/versions/ -name "RobloxStudioBeta.exe")"
  #         '';
  #     };
  # };
}
