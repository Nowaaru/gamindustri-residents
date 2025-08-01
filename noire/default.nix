# TODO: holy shit just
# remove all of these and start
# using Folder/Default.nix
{
  programs,
  configure,
  user,
  ...
}: {
  imports = [
    # Developer goodies.
    programs.dev.formatters.dprint

    programs.dev.langs.javascript.typescript
    programs.dev.langs.javascript.node
    programs.dev.langs.javascript.bun

    programs.dev.langs.dotnet
    programs.dev.langs.lua

    programs.dev.nvim

    programs.dev.git
    programs.dev.lazygit

    # Gaming and the like.
    programs.gaming.minecraft
    programs.gaming.lutris
    programs.gaming.steam
    programs.gaming.osu

    # Social media and social utilities.
    programs.social.discord.vesktop

    # General things, auxiliary functionalities.
    programs.misc.qol.night-light
    programs.misc.qol.kdenlive
    programs.misc.qol.obsidian
    programs.misc.bitwarden

    programs.misc.terminal.all

    programs.misc.dunst
    programs.misc.print-screen

    programs.misc.video
    programs.misc.audio
    programs.misc.clip
    programs.misc.disk
    programs.misc.dir
    programs.misc.obs

    # Skate through the world, there's no one way to grind...
    programs.entertainment.music.mixers.ncpamixer
    programs.entertainment.music.players.spotify
    programs.entertainment.jellyfin

    # Games by those who rule the world.
    # user.programs.an-anime-team.anime-game
    # user.programs.an-anime-team.honkers-railway
    # user.programs.an-anime-team.honkers

    # Desktop
    user.programs.plasma

    # Images
    user.programs.hydrus

    # Browsers
    user.programs.browsers

    # Applications/Misc
    user.programs.blender
    user.programs.r2modman
    user.programs.nmm
    user.programs.rojo
    user.programs.umu
    user.programs.libre
    user.programs.kitty
    user.programs.mangohud

    # Multi-GPU
    user.programs.nixgl

    # UI
    user.programs.awesome
    user.programs.gimp
    user.programs.piper
    user.programs.qt
    user.programs.fonts.nerdfont.all

    # Games
    user.programs.vintagestory
  ];

  dconf.settings = {
    "org/gnome/mutter" = {
      experimental-features = ["scale-monitor-framebuffer"];
    };
  };

  fonts.fontconfig.enable = true;

  nixpkgs.config.allowUnfree = true;

  xdg = configure "xdg";

  i18n = configure "ime";
}
