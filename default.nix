{ nixpkgs ? import <nixpkgs> {}, compiler ? "ghc843" }:
nixpkgs.haskell.packages.${compiler}.callPackage ./scylla.nix { }
