{ lib, ... }:

let
  attrsToListRec = attrSet:
    builtins.concatMap (x:
      if builtins.isAttrs x && !lib.isDerivation x
        then attrsToListRec x
        else [x]
    )
    (builtins.attrValues attrSet)
  ;

  concatAttrSetOfList = s1: s2:
    builtins.zipAttrsWith (_: builtins.concatLists) [s1 s2]
  ;

  readFileLines = path: builtins.readFile path |> lib.splitString "\n";

  importOr = path: default: if builtins.pathExists path
    then import path
    else default
  ;

  # Reads for directories inside <hostsDirPath>
  # The names of these directories will be the attribute names in
  # the returned attrset.
  # The attribute values will be the result of <nixosSystem> with
  # modules being <hostsDirPath>/<host>/default.nix
  # The hostname will be set automatically.
  # Directories listed in <skipEntries> will be skipped.
  # <args> will be called with the value contained in
  # <hostsDirPath>/<host>/system.nix, and the result will be
  # passed as argument to <nixosSystem>
  # AttrSet -> AttrSet of NixOS configurations
  readNixOSHosts = {
    # (Attrset -> NixOS configuration)
    nixosSystem,

    # Path
    hostsDirPath,

    # [String]
    skipEntries ? [ ],

    # (String -> AttrSet)
    args ? (_: { }),
  }:
    builtins.readDir hostsDirPath
      |> lib.filterAttrs (n: v: v == "directory")
      |> lib.filterAttrs (n: v: !builtins.elem n skipEntries)
      |> builtins.mapAttrs (n: v: let
        hostPath = /${hostsDirPath}/${n};
        system = let
          path = /${hostPath}/system.nix;
          default = "x86_64-linux";
        in importOr
          path
          (lib.warn "File ${path} not found, defaulting to ${default}" default)
        ;
        evalArgs = args { inherit system; };
      in nixosSystem (evalArgs // {
        inherit system;
        modules = [
          ./nixos/modules
          /${hostPath}/configuration.nix
          { networking.hostName = n; }
        ] ++ evalArgs.modules or [ ];
      }))
  ;
in {
  inherit
    attrsToListRec
    concatAttrSetOfList
    readFileLines
    readNixOSHosts
  ;
}
