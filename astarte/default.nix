{
  withSystem,
  configure,
  pkgs,
  user,
  programs,
  ...
}: {
  imports = [
    # Required for this user to function.
    user.programs.fonts.nerdfont.all
    user.programs.audio
    user.programs.kitty
    user.programs.nvim
    user.programs.yazi
    user.programs.qt

    # Contact
    programs.social.discord.vesktop

    # Necessities
    programs.misc.qol.obsidian
    programs.misc.bitwarden
    user.programs.browsers

    # Programming / Development
    programs.dev.lazygit
    programs.dev.git
    user.programs.rojo

    # Entertainment
    programs.entertainment.music.players.spotify

    # Break-taking.
    user.programs.vintagestory
    user.programs.mangohud
    programs.gaming.steam

    # Quality of Life
    programs.misc.qol.night-light
  ];

  home = {
    packages = with pkgs;
      withSystem "x86_64-linux" ({inputs', ...}: [
        wl-clip-persist
        wl-clipboard
        clipse

        inputs'.hyprpicker.packages.hyprpicker
        inputs'.hyprcursor.packages.hyprcursor
        inputs'.quickshell.packages.default

        wlsunset
        hyprdim
        swww
        btop
        ncpamixer

        # utilities
        font-awesome
      ]);

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
