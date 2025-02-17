{ stdenv, imagemagick, envsubst, python3Full, zip, nopng ? false, ... }:
stdenv.mkDerivation {
  pname = "BetaNuBranding";
  version = "1.0.0";

  src = ./src;

  nativeBuildInputs = [ imagemagick envsubst python3Full zip ];

  buildPhase = ''
    python build.py
    ${if nopng then "" else "mogrify -format png -density 2500 -background none out/*.svg" }
  '';

  installPhase = ''
    mkdir -p $out
    cp -r out/* $out
  '';
}