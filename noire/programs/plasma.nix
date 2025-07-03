{
  inputs,
  lib,
  configure,
  pkgs,
  ...
}: {
  imports = [
    (lib.trace (builtins.attrNames inputs) inputs).plasma-manager.homeManagerModules.plasma-manager
    inputs.gamindustri-utils.homeManagerModules.plasma
  ];

  programs.plasma = configure "plasma";

  xdg.portal = {
    enable = true;

    extraPortals = [
      pkgs.kdePackages.xdg-desktop-portal-kde
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
    ];

    config = {
      "common".default = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.kdePackages.xdg-desktop-portal-kde
        pkgs.xdg-desktop-portal-wlr
      ];
      "kde".default = [
        pkgs.kdePackages.xdg-desktop-portal-kde
      ];
    };
  };
}
