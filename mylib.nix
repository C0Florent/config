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

  # Reads for directories inside <hostsDirPath>
  # The names of these directories will be the attribute names in
  # the returned attrset.
  # The attribute values will the result of <nixosSystem> with
  # modules being <hostsDirPath>/<host>/default.nix
  # The hostname will be set automatically.
  # Directories listed in <skipEntries> will be skipped
  # (Attrset -> NixOS configuration ) -> Path -> [String] -> AttrSet -> AttrSet of NixOS configurations
  readNixOSHosts = nixosSystem: hostsDirPath: skipEntries: attrs:
    builtins.readDir hostsDirPath
      |> lib.filterAttrs (n: v: v == "directory")
      |> lib.filterAttrs (n: v: !builtins.elem n skipEntries)
      |> builtins.mapAttrs (n: v: nixosSystem ({
            modules = [
              (hostsDirPath + "/${n}")
              { networking.hostName = n; }
            ];
          } // attrs
        ))
  ;
in {
  inherit
    attrsToListRec
    concatAttrSetOfList
    readFileLines
    readNixOSHosts
  ;
}
