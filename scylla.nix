{ mkDerivation, aeson, base, containers, data-default, stdenv, time
}:
mkDerivation {
  pname = "scylla";
  version = "0.1.0.0";
  src = ./.;
  libraryHaskellDepends = [
    aeson base containers data-default time
  ];
  doHaddock = false;
  homepage = "https://github.com/ci-realm/scylla";
  description = "Scylla CI data types";
  license = stdenv.lib.licenses.bsd3;
}
