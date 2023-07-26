{ buildDartApplication, lib, fetchurl, fetchgit }:
buildDartApplication rec {
  pname = "spaghettiserver";
  version = "0.0.0";
  src = fetchurl {
    name = "mrcyjanek_spaghetti.tar.gz";
    url = "https://git.mrcyjanek.net/mrcyjanek/spaghetti/archive/0000000000000000000000000000000000000000.tar.gz";
    hash = "";
  };
  
  pubspecLockFile = ./pubspec.lock;
  vendorHash = "sha256-MwX204CPcREcPcP8GTvd6TuLr67mMB0D1QVb8LxyufY=";
}