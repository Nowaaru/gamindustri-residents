{
  # Prerequisites for screen tearing in
  # Hyprland.
  #
  # Might need to be deleted when double
  # buffering doesn't suck.
  general.allow_tearing = true;

  windowrulev2 = [
    # tear if the app is a game or a video (like mpv? i wonder if browser videos work...)
    "immediate, content:game"
    "immediate, content:video"
    # tear if the app sets maximize/fullscreen, otherwise forced fullscreen will allow tear
    "immediate, fullscreenstate: 3 2"
  ];
}
