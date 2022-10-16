{ mkDerivation, attoparsec, base, base64-bytestring, byteable
, bytestring, cereal, criterion, cryptohash, deepseq, either
, fetchgit, hex, lib, QuickCheck, tasty, tasty-hunit
, tasty-quickcheck, transformers
}:
mkDerivation {
  pname = "hmacaroons";
  version = "0.5.0.0";
  src = fetchgit {
    url = "https://github.com/jtanguy/hmacaroons";
    sha256 = "0qd1ifx1rzcv8rc74vb5xxgi544qxclx8ky3wjg0nbj22hpvvg6j";
    rev = "6fbca87836a4baef171c5ffc774387766c709fbf";
    fetchSubmodules = true;
  };
  libraryHaskellDepends = [
    attoparsec base base64-bytestring byteable bytestring cereal
    cryptohash deepseq either hex transformers
  ];
  testHaskellDepends = [
    attoparsec base base64-bytestring byteable bytestring cereal
    cryptohash deepseq either hex QuickCheck tasty tasty-hunit
    tasty-quickcheck transformers
  ];
  benchmarkHaskellDepends = [
    attoparsec base base64-bytestring byteable bytestring cereal
    criterion cryptohash deepseq either hex transformers
  ];
  homepage = "https://github.com/jtanguy/hmacaroons";
  description = "Haskell implementation of macaroons";
  license = lib.licenses.bsd3;
}
