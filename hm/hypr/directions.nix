{ pkgs, lib, ... }:

let
  left  = "h";
  down  = "j";
  up    = "k";
  right = "l";
in

{
  wayland.windowManager.hyprland.settings = {
    bind = [
      "$mainMod, ${left},  movefocus, l"
      "$mainMod, ${down},  movefocus, d"
      "$mainMod, ${up},    movefocus, u"
      "$mainMod, ${right}, movefocus, r"

      "$mainMod + SHIFT, ${left},  swapwindow, l"
      "$mainMod + SHIFT, ${down},  swapwindow, d"
      "$mainMod + SHIFT, ${up},    swapwindow, u"
      "$mainMod + SHIFT, ${right}, swapwindow, r"

      "$mainMod + CTRL, ${left},  workspace, m-1"
      "$mainMod + CTRL, ${right}, workspace, m+1"
      "$mainMod + CTRL, ${up},    workspace, r+1"
      "$mainMod + CTRL, ${down},  workspace, r-1"

      "$mainMod + CTRL + SHIFT, ${left},  movetoworkspace, r-1"
      "$mainMod + CTRL + SHIFT, ${right}, movetoworkspace, r+1"
      "$mainMod + CTRL + SHIFT, ${up},    movetoworkspace, m+1"
      "$mainMod + CTRL + SHIFT, ${down},  movetoworkspace, m-1"
    ];

    bindte = let
      px = builtins.toString 72;
    in[
      "$mainMod + ALT, ${left},  resizeactive, -${px} 0"
      "$mainMod + ALT, ${right}, resizeactive,  ${px} 0"
      "$mainMod + ALT, ${up},    resizeactive, 0 -${px}"
      "$mainMod + ALT, ${down},  resizeactive, 0  ${px}"
    ];
  };
}
