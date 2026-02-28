{ pkgs, lib }:

let
  version = "1.5.1";
  nbb-jar = builtins.fetchurl {
    url = "https://github.com/Ninjabrain1/Ninjabrain-Bot/releases/download/${version}/Ninjabrain-Bot-${version}.jar";
    sha256 = "1p5dbjj23kr01w4arcd8p7cc44prdxj24m5hgjyvwki2c41vs6s7";
  };
  java = lib.getExe pkgs.javaPackages.compiler.temurin-bin.jdk-25;
  # runtime dependencies, discovered by trial and error
  libs = [
    pkgs.libxkbcommon
    pkgs.libxtst
    pkgs.xorg.libxcb
    pkgs.xorg.libX11
    pkgs.libxt
    pkgs.libxinerama
  ];
in (pkgs.writeShellScriptBin "ninjabrain-bot" ''
    LD_LIBRARY_PATH="${lib.makeLibraryPath libs}" exec ${java} -Dawt.useSystemAAFontSettings=on -jar ${nbb-jar}
'').overrideAttrs (finalAttrs: previousAttrs: {
  nativeBuildInputs = (previousAttrs.nativeBuildInputs or []) ++ libs;
})
