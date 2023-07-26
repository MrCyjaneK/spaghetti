{ buildDartApplication, lib, fetchurl, fetchgit }:
buildDartApplication rec {
  pname = "spaghettiserver";
  version = "0.0.0";
  src = fetchurl {
    name = "mrcyjanek_spaghetti.tar.gz";
    url = "https://git.mrcyjanek.net/mrcyjanek/spaghetti/archive/a3f62cd025d4d00f8423aae49e3d3fea02824390.tar.gz";
    hash = "sha256-JWihfhzmRxnoN5oT7ajwTjwAEWqAK/oHNUUAcjY8Wzw=";
  };
  
  pubspecLockFile = ./pubspec.lock;
  vendorHash = "sha256-MwX204CPcREcPcP8GTvd6TuLr67mMB0D1QVb8LxyufY=";
}