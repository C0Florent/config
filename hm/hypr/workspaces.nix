{ pkgs, lib, config, ... }:

let
  workspaceRange = lib.range 1 12;

  workspaces = map (id: {
    key = "code:${builtins.toString (9 + id)}";
    ws  = "r~${builtins.toString id}";
  }) workspaceRange
  ++ [{
    key = "Tab";
    ws  = "previous";
  }];

  # ((a -> b) -> [a] -> c) -> (KEY -> WORKSPACE -> b) -> c
  traverse-workspaces = mapFunc: f: mapFunc (w: f w.key w.ws) workspaces;

  # (KEY -> WORKSPACE -> a) -> [a]
  map-workspaces = traverse-workspaces map;

  # (KEY -> WORKSPACE -> [a]) -> [a]
  concatMap-workspaces = traverse-workspaces builtins.concatMap;
in
{
  wayland.windowManager.hyprland.settings = {
    bind = concatMap-workspaces (key: ws: [
      "$mainMod, ${key}, workspace, ${ws}"
      "$mainMod + SHIFT + CTRL, ${key}, movetoworkspace, ${ws}"
      "$mainMod + SHIFT, ${key}, movetoworkspace, ${ws}"
    ]);
  };
}
