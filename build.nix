{ stdenv, imagemagick, envsubst, python3Full, ... }:
stdenv.mkDerivation {
  pname = "BetaNuBranding";
  version = "1.0.0";

  src = ./.;

  nativeBuildInputs = [ imagemagick envsubst python3Full ];

  buildPhase = ''
    python build.py
  '';

  installPhase = ''
    mkdir -p $out
    cp -r out/* $out
  '';
}