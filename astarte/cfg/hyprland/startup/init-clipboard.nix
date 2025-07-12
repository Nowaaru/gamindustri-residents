{
  exec-once = [
    "clipse -wl-store"

    "wl-paste --type image --watch clipse -wl-store" # Stores only image data
    "wl-paste --type text --watch clipse -wl-store" # Stores only text data
    # "wl-paste -p --watch wl-copy -p ''" # disable primary buffer
  ];

  windowrulev2 = [
    "float,class:(clipse)"
    "size 622 652,class:(clipse)"
    "stayfocused,class:(clipse)"
    "center 1,class:(clipse)"
  ];
}
