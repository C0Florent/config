{ ... }:

{
  wayland.windowManager.hyprland = {
    animations = {
      windows     = "1, 3.5, easeOutBack, slide";
      windowsMove = "1, 3.5, easeOutBack, slide";
      windowsOut  = "1, 5,   easeOutBack, slide";

      workspaces = "1, 3, easeOutSteep";
    };

    settings = {
      bezier = [
        "easeOutBack, 0.07, 1.4, 0.4, 0.92"
        "easeOutCubic, 0.22, 0.61, 0.36, 1"
        "easeInCubic, 0.61, 0.22, 1, 0.36"
        "easeInOutCubic, 0.65, 0.05, 0.36, 1"

        "easeOutSteep, 0.19, 1, 0.22, 1"
      ];

      windowrulev2 = [
        "animation gnomed, onworkspace:w[tv1]"
        "animation gnomed, floating:1"
      ];
    };
  };
}
