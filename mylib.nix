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
in {
  inherit
    attrsToListRec
    concatAttrSetOfList
    readFileLines
  ;
}
