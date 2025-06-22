{ pkgs, lib, mycfg, ... }:

let
  left  = "h";
  down  = "j";
  up    = "k";
  right = "l";
in

{
  mycfg.hypr.superbinds.superbinds = {
    bind = [
      ", ${left},  movefocus, l"
      ", ${down},  movefocus, d"
      ", ${up},    movefocus, u"
      ", ${right}, movefocus, r"

      "SHIFT, ${left},  swapwindow, l"
      "SHIFT, ${down},  swapwindow, d"
      "SHIFT, ${up},    swapwindow, u"
      "SHIFT, ${right}, swapwindow, r"

      "SHIFT + ALT, ${left},  movewindow, l"
      "SHIFT + ALT, ${down},  movewindow, d"
      "SHIFT + ALT, ${up},    movewindow, u"
      "SHIFT + ALT, ${right}, movewindow, r"

      "CTRL, ${left},  workspace, m-1"
      "CTRL, ${right}, workspace, m+1"
      "CTRL, ${up},    workspace, r+1"
      "CTRL, ${down},  workspace, r-1"

      "CTRL + SHIFT, ${left},  movetoworkspace, r-1"
      "CTRL + SHIFT, ${right}, movetoworkspace, r+1"
      "CTRL + SHIFT, ${up},    movetoworkspace, m+1"
      "CTRL + SHIFT, ${down},  movetoworkspace, m-1"

      "CTRL + SHIFT + ALT, ${left},  movetoworkspacesilent, r-1"
      "CTRL + SHIFT + ALT, ${right}, movetoworkspacesilent, r+1"
      "CTRL + SHIFT + ALT, ${up},    movetoworkspacesilent, m+1"
      "CTRL + SHIFT + ALT, ${down},  movetoworkspacesilent, m-1"
    ];

    bindte = let
      px = builtins.toString 72;
    in [
      "ALT, ${left},  resizeactive, -${px} 0"
      "ALT, ${right}, resizeactive,  ${px} 0"
      "ALT, ${up},    resizeactive, 0 -${px}"
      "ALT, ${down},  resizeactive, 0  ${px}"
    ];
  };
}
