{ pkgs, lib, ... }:

{
  xdg.configFile."ghc/ghci.conf" = let
    toTrueColor = { r, g, b }: let
      s = builtins.toString;
      c = "2;${s r};${s g};${s b}";
    in { fg = "38;${c}"; bg = "48;${c}"; };
    ansiColor = { fg ? "", bg ? "", }: let
      sep = lib.optionalString (builtins.stringLength fg != 0 && builtins.stringLength bg != 0) ";";
    in ''\ESC[${bg}${sep}${fg}m\STX'';

    hs-purp-dark = toTrueColor { r = 69; g = 58; b = 98; };
    hs-purp = toTrueColor { r = 94; g = 80; b = 134; };
    hs-purp-light = toTrueColor { r = 143; g = 78; b = 139; };

    # up-left, down-left, down-right, and up-right half blocks
    half-ul = ''\xe0bc'';
    half-dl = ''\xe0b8'';
    half-dr = ''\xe0ba'';
    half-ur = ''\xe0be'';
  in {
    text = ''
       -- Set the GHCi prompt to be a truecolor haskell logo
       -- (unfortunately without the equals sign)
      :set prompt "\n${ansiColor { fg = hs-purp-dark.fg; bg = "40"; }}${half-ur}${half-dl}${ansiColor { fg = hs-purp.fg; }}${half-ur}${half-dl}${ansiColor{ fg = hs-purp-light.fg; bg = "49"; }} %s\n${ansiColor { fg = hs-purp-dark.fg; }}${half-dr}${half-ul}${ansiColor { fg = hs-purp.fg; }}${half-dr}${ansiColor { fg = "30"; bg = hs-purp.bg; }}\x1fb6f${ansiColor { bg = "49"; fg = hs-purp.fg; }}${half-dl}${ansiColor { fg = "0"; }} "
    '';
  };
}
