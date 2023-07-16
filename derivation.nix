{ buildDartApplication, lib, fetchurl, fetchgit }:
buildDartApplication rec {
  pname = "spaghettiserver";
  version = "0.0.0";
  src = fetchurl {
    name = "mrcyjanek_spaghetti.tar.gz";
    url = "https://git.mrcyjanek.net/mrcyjanek/spaghetti/archive/b25f074d243004070bba5432412134f8011a133b.tar.gz";
    hash = "sha256-q8WMZCDWiaqFpbD6OvJ98KDDFWaX9idPvWbp1seyW+I=";
  };
  
  pubspecLockFile = ./pubspec.lock;
  vendorHash = "sha256-MwX204CPcREcPcP8GTvd6TuLr67mMB0D1QVb8LxyufY=";
}