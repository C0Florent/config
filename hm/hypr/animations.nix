{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    animation = [
      "windows,    1, 3.5, easeOutBack, slide"
      "windowsOut, 1, 5,   easeOutBack, slide"
    ];

    bezier = [
      "easeOutBack, .07, 1.4, 0.4, .92"
    ];

    windowrulev2 = [
      "animation gnomed, onworkspace:w[tv1]"
      "animation gnomed, floating:1"
    ];
  };
}
