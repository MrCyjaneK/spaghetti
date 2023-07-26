{ pkgs ? import <nixpkgs> {} }:
{
  spaghettiserver = pkgs.callPackage ./derivation.nix {};
}