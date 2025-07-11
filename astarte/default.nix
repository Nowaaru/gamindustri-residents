{
  configure,
  inputs,
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      inputs.hyprpicker.packages.${pkgs.system}.hyprpicker
      inputs.hyprcursor.packages.${pkgs.system}.hyprcursor
      wlsunset
      hyprdim
      swww

      # utilities
      font-awesome
    ];

    # activation = {
    #   hyprland_reload =
    #     lib.hm.dag.entryAfter ["writeBoundary"] (ifHyprland "${hyprland}/bin/hyprctl reload");
    # };
  };
  wayland.windowManager.hyprland = {
    enable = true;
    settings = (configure "hyprland").hypr;
    sourceFirst = true;

    systemd = {
      enable = true;
      enableXdgAutostart = true;
    };
  };

  fonts.fontconfig.enable = true;

  nixpkgs.config.allowUnfree = true;

  xdg = configure "xdg";
}
