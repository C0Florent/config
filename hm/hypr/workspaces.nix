{ pkgs, lib, config, mycfg, ... }:

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
  mycfg.hypr.superbinds.superbinds = {
    bind = concatMap-workspaces (key: ws: [
      ", ${key}, workspace, ${ws}"

      "SHIFT + CTRL, ${key}, movetoworkspace, ${ws}"
      "SHIFT,        ${key}, movetoworkspace, ${ws}"

      "SHIFT +        ALT, ${key}, movetoworkspacesilent, ${ws}"
      "SHIFT + CTRL + ALT, ${key}, movetoworkspacesilent, ${ws}"
    ]);
  };
}
