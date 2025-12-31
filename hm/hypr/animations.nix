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

      layerrule = [{
        name = "fix_screenshot";
        no_anim = true;
        "match:namespace" = "selection";
      }];

      windowrule = [{
       name = "singlewindow-1";
       animation = "gnomed";
       "match:float" = 1;
      } {
        name = "singlewindow-2";
        animation = "gnomed";
        "match:workspace" = "w[tv1]";
      }];
    };
  };
}
