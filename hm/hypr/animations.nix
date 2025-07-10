{ ... }:

{
  wayland.windowManager.hyprland = {
    animations = {
      windows     = "1, 3.5, easeOutBack, slide";
      windowsMove = "1, 3.5, easeOutBack, slide";
      windowsOut  = "1, 5,   easeOutBack, slide";
    };

    settings = {
      bezier = [
        "easeOutBack, .07, 1.4, 0.4, .92"
        "easeOutCubic, .22, .61, .36, 1"
        "easeInCubic, .61, .22, 1, .36"
      ];

      windowrulev2 = [
        "animation gnomed, onworkspace:w[tv1]"
        "animation gnomed, floating:1"
      ];
    };
  };
}
