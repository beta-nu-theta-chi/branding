{ stdenv, imagemagick, envsubst, python3Full, zip, ... }:
stdenv.mkDerivation {
  pname = "BetaNuBranding";
  version = "1.0.0";

  src = ./src;

  nativeBuildInputs = [ imagemagick envsubst python3Full zip ];

  buildPhase = ''
    python build.py
  '';

  installPhase = ''
    mkdir -p $out
    cp -r out/* $out
  '';
}