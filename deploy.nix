{ src, stdenv, zip, ... }:
stdenv.mkDerivation {
  inherit src;
  pname = "GH-Action-builder";
  version = "0.0.1";
  nativeBuildInputs = [ zip ];

  installPhase = ''
    mkdir -p $out
    zip $out/branding.zip ./*
  '';
}