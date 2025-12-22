{ ... }:

{
  wayland.windowManager.hyprland.settings.dwindle = {
    force_split = 2;
    preserve_split = true;
    precise_mouse_move = true;
  };

  # binds written in dwindle.nix because they are dwindle-specific
  mycfg.hypr.superbinds.superbinds = {
    bind = [
      "   , s, layoutmsg, togglesplit"
      "ALT, s, layoutmsg, swapsplit"
    ];
  };
}
