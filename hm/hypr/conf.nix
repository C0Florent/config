{ pkgs, lib, config, mycfg, ... }:

let
  lmb = "mouse:272";
  rmb = "mouse:273";
  mid = "mouse:274";
in

{
  imports = [
    ./fn_keys.nix
    ./directions.nix
    ./workspaces.nix
  ];

  mycfg.hypr.superbinds.superbinds = {
    bindm = [
      # Allow actions to be performed with LMB or SPACE for touchpad control
      ", ${lmb}, movewindow"
      ", SPACE,  movewindow"

      "ALT, ${lmb}, resizewindow"
      "ALT, SPACE,  resizewindow"
      ", ${rmb}, resizewindow"
    ];

    bind = [
      ", Q, exec, $launchApp alacritty"
      "SHIFT, Q, exec, [float] $launchApp alacritty"
      ", W, exec, $launchApp firefox"

      ", C, killactive"
      "SHIFT , C, forcekillactive"
      ", ${mid}, killactive"
      "SHIFT , ${mid}, forcekillactive"

      ", F, togglefloating"
      "SHIFT, F, fullscreen"
    ];
  };

  wayland.windowManager.hyprland = {
    settings = {
      "$mainMod" = "SUPER";
      "$launchApp" = "uwsm app --";

      layerrule = [
        "noanim, selection"
      ];

      general = {
        # Hacky hard-coded night owl gradient (cyan-blue-magenta)
        "col.active_border" = "rgb(7fdbca) rgb(82aaff) rgb(c792ea) 45deg";

        gaps_in = 4;
        gaps_out = 12;

        no_focus_fallback = true;
        resize_on_border = true;
        border_size = 2;
      };

      decoration = {
        rounding = 8;
      };

      # Some session-related binds that we specfically don't want in superbinds
      bind = [
        "$mainMod + CTRL, X, exec, uwsm stop"
        "$mainMod, Escape, exec, hyprlock"
      ];

      input = {
        kb_layout = "fr";
        kb_variant = "oss";
        numlock_by_default = true;

        repeat_delay = 180;
        repeat_rate = 50;

        touchpad = {
          disable_while_typing = false;
        };
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_min_fingers = true;
        workspace_swipe_distance = 200;
      };

      misc = {
        disable_hyprland_logo = true;
        animate_manual_resizes = true;
        anr_missed_pings = 3;
      };
    };
  };
}
