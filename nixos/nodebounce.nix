let
  mouse-name = "USB Gaming Mouse";
in {
  environment.etc."libinput/local-overrides.quirks".text = ''
    [${mouse-name}]
    MatchName=${mouse-name}
    ModelBouncingKeys=1
  '';
}
