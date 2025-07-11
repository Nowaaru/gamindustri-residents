{
  inputs,
  pkgs,
  lib,
  ...
}: let
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

      "text/html" = "zen.desktop";
      "x-scheme-handler/discord" = "vesktop.desktop";
      "x-scheme-handler/bitwarden" = "bitwarden.desktop";
    };
  };

  userDirs = {
    enable = true;
    createDirectories = true;
  };

  portal.xdgOpenUsePortal = true;
}
