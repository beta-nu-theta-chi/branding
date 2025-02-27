{ stdenv, imagemagick, envsubst, python3Full, zip, util-linux, nopng ? false, bg ? "none", ... }:
stdenv.mkDerivation {
  pname = "BetaNuBranding";
  version = "1.0.1";

  src = ./src;

  nativeBuildInputs = [ imagemagick envsubst python3Full zip util-linux ];

  buildPhase = ''
    python build.py
    cd out
    ${if nopng then "" else "mogrify -format png -density 2500 -background ${bg} *.svg" }
    cd ..
  '';

  installPhase = ''
    mkdir -p $out
    cp -r out/* $out
  '';
}