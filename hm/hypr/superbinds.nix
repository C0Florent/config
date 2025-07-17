{ pkgs, lib, options, config, mycfg, ... }:

let
  hyprlandcfg = config.wayland.windowManager.hyprland;
in
{
  mycfg.hypr.superbinds = {
    mod = "$mainMod";

    # Add config on top of the default enterBind
    enterBind = {
      # By adding more actions to the enter bind, it will execute them all
      # Here, we change the gaps_in gaps_out to give a visual cue that we
      # are in the submap. We also tweak animations because the transition
      # is a bit off with my global animations
      bindr = [
        "SUPER, Super_L, exec, hyprctl --batch '${lib.concatStringsSep " ; " [
          "keyword animation windowsMove, 1, 4, easeInOutCubic" # transition curve
          "keyword general:gaps_out 36"
          "keyword general:gaps_in 24"
        ]}'"
        # After .4 secs (the duration of anim set above), reset to my usual
        # anim config, so that spawning/killing windows feels as usual
        "SUPER, Super_L, exec, sleep .4 && hyprctl keyword animation ${hyprlandcfg.animations.windowsMove}"
      ] ++ options.mycfg.hypr.superbinds.enterBind.default.bindr;
    };

    # Add config on top of the default exitBind
    exitBind = {
      # Same as above, but we are restoring default config here
      bind = [
        ", Escape, exec, hyprctl --batch '${lib.concatStringsSep " ; " [
          "keyword animation windowsMove, 1, 2, easeInCubic" # transition curve
          "keyword general:gaps_out ${builtins.toString hyprlandcfg.settings.general.gaps_out}"
          "keyword general:gaps_in ${builtins.toString hyprlandcfg.settings.general.gaps_in}"
        ]}'"
        # After .2 secs (the duration of anim set above), reset to my usual
        # anim config, so that spawning/killing windows goes back to normal
        ", Escape, exec, sleep .2 && hyprctl keyword animation ${hyprlandcfg.animations.windowsMove}"
      ] ++ options.mycfg.hypr.superbinds.exitBind.default.bind;
    };
  };
}
