{
  theme,
  pkgs,
  ...
}: let
  fileManager = "kitty yazi";
  terminal = "kitty";
  browser = "vivaldi";
  mainMod = "SUPER";

  menu = "${pkgs.fuzzel}/bin/fuzzel -D no";
  dmenu = "${pkgs.fuzzel}/bin/fuzzel -D no --dmenu";

  screenshot_dir = "$XDG_PICTURES_DIR/Screenshots";
  print_screen = "${pkgs.grimblast}/bin/grimblast --notify --freeze copysave area ${screenshot_dir}"; # "fish ~/.diary/Config/Fish/clip.fish";
  themeDir = theme.background + "/..";
in {
  bind = [
    ###############################
    # Program keybinds.
    "${mainMod}, Q, exec, ${terminal}" # Open terminal.
    "${mainMod}, F, exec, ${browser}" # Open browser.
    "${mainMod}, E, exec, ${fileManager}" # Open the file manager.
    "${mainMod}, R, exec, hyprctl reload"

    ###############################
    # Administrative keybinds.
    "${mainMod}, M, exit," # Logout.
    "${mainMod}, C, killactive," # Kill selected window.
    "${mainMod} SHIFT, SPACE, togglefloating," # Make the active window float.

    ###############################
    # Global functionality 'n things.
    "${mainMod}, J, togglesplit," # ???

    "${mainMod}, SPACE, exec, ${menu}" # Fuzzel.

    # Clipboard.
    # "${mainMod}, V, exec, kitty --class clipse --instance-group clipse --single-instance=yes clipse"
    "${mainMod}, V, exec, ${pkgs.kitty}/bin/kitty --title clipse --class clipse -e nu -c ${pkgs.clipse}/bin/clipse"
    "${mainMod} SHIFT, V, exec, ${pkgs.clipse}/bin/clipse -clear-all & dunstify 'Clipboard cleared.'"

    "${mainMod} SHIFT, C, exec, ${print_screen}" # Print screen.
    # ",mouse:273, exec, ${print_screen} --kill,^(slurp)"
    ###############################
    # Window controls.

    # Move focus with mainMod + arrow keys.
    "${mainMod}, left, movefocus, l"
    "${mainMod}, right, movefocus, r"
    "${mainMod}, up, movefocus, u"
    "${mainMod}, down, movefocus, d"

    # Move window with mainMod + SHIFT + arrow keys.
    "${mainMod} SHIFT, left, movewindow, l"
    "${mainMod} SHIFT, right, movewindow, r"
    "${mainMod} SHIFT, up, movewindow, u"
    "${mainMod} SHIFT, down, movewindow, d"

    # Switch workspaces with mainMod + [0-9].
    "${mainMod}, 1, workspace, 1"
    "${mainMod}, 2, workspace, 2"
    "${mainMod}, 3, workspace, 3"
    "${mainMod}, 4, workspace, 4"
    "${mainMod}, 5, workspace, 5"
    "${mainMod}, 6, workspace, 6"
    "${mainMod}, 7, workspace, 7"
    "${mainMod}, 8, workspace, 8"
    "${mainMod}, 9, workspace, 9"
    "${mainMod}, 0, workspace, 10"

    # Move active window to a workspace with mainMod + SHIFT + [0-9].
    "${mainMod} SHIFT, 1, movetoworkspace, 1"
    "${mainMod} SHIFT, 2, movetoworkspace, 2"
    "${mainMod} SHIFT, 3, movetoworkspace, 3"
    "${mainMod} SHIFT, 4, movetoworkspace, 4"
    "${mainMod} SHIFT, 5, movetoworkspace, 5"
    "${mainMod} SHIFT, 6, movetoworkspace, 6"
    "${mainMod} SHIFT, 7, movetoworkspace, 7"
    "${mainMod} SHIFT, 8, movetoworkspace, 8"
    "${mainMod} SHIFT, 9, movetoworkspace, 9"
    "${mainMod} SHIFT, 0, movetoworkspace, 10"

    # Scroll through existing workspaces with mainMod + scroll.
    "${mainMod}, mouse_down, workspace, e+1"
    "${mainMod}, mouse_up, workspace, e-1"

    # Maximizing, minimizing, and fullscreening.
    ", F11, fullscreen, 0"
    "${mainMod}, equal, fullscreen, 1"

    ###############################
    # Workspaces.
    "${mainMod}, S, togglespecialworkspace, magic" # Special workspace (scratchpad).
    "${mainMod} SHIFT, S, movetoworkspace, special:magic"

    "${mainMod}, D, togglespecialworkspace, discord" # Discord workspace.
    "${mainMod} SHIFT, D, movetoworkspace, special:discord"

    "${mainMod}, O, togglespecialworkspace, overlay" # Game overlays.
    "${mainMod} SHIFT, O, movetoworkspace, special:overlay"
  ];

  bindm = [
    # Move/resize windows with mainMod + LMB/RMB and dragging.
    "${mainMod}, mouse:272, movewindow"
    "${mainMod}, mouse:273, resizewindow"
  ];
}
