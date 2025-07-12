{
  pkgs,
  master,
  ...
}: {
  programs.yazi = {
    enable = true;
    package = master.yazi;
    plugins = {
      inherit
        (master.yaziPlugins)
        git
        glow
        diff
        chmod
        ouch
        bypass
        restore
        lazygit
        projects
        rich-preview
        vcs-files
        mediainfo
        toggle-pane
        smart-paste
        full-border
        relative-motions
        yatline
        yatline-catppuccin
        duckdb
        ;
    };
  };
}
