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
    text = lib.concatStrings [
      ''
        -- \\  Set the GHCi prompt to be a truecolor haskell logo
        -- //\ (unfortunately without the equals sign)
      ''

      # The whole prompt will be a single haskell string, written here
      # as several lines for readability
      '':set prompt "\n''

      # Upper part, the two \\ followed by the loaded modules (%s)
      ''${ansiColor { fg = hs-purp-dark.fg; bg = "49";  }}${half-ur}${half-dl}'' # 1st \
      ''${ansiColor { fg = hs-purp.fg;                  }}${half-ur}${half-dl}'' # 2nd \
      ''${ansiColor { fg = hs-purp-light.fg; bg = "49"; }} %s\n'' # module info

      # Lower part (//\ shape), NOTE the /\ is rendered with fg and bg swapped
      ''${ansiColor { fg = hs-purp-dark.fg;       }}${half-dr}${half-ul}'' # 1st /
      ''${ansiColor { fg = hs-purp.fg;            }}${half-dr}'' # 1st char of the /\
      ''${ansiColor { fg = "30"; bg = hs-purp.bg; }}\x1fb6f'' # Hacky /\
      ''${ansiColor { bg = "49"; fg = hs-purp.fg; }}${half-dl}'' # Close the \
      ''${ansiColor { fg = "0"; }} "'' # Reset term color
     ];
  };
}
