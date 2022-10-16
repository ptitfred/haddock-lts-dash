{ pkgs ? import <nixpkgs> {}
}:

with pkgs.haskellPackages.override {
  overrides = self: super: {
    hspec-pg-transact = pkgs.haskell.lib.dontCheck super.hspec-pg-transact;
    pg-entity         = pkgs.haskell.lib.dontCheck super.pg-entity;
    pg-transact       = pkgs.haskell.lib.dontCheck super.pg-transact;
    hmacaroons        = super.callPackage packages/hmacaroons.nix {};
    biscuit-haskell   = pkgs.haskell.lib.dontCheck super.biscuit-haskell;
  };
};

{
  clean = [
    aeson pipes servant-client servant-server
    effectful Cabal-syntax text-display optics-core optics
    hmacaroons formatting
  ];
  broken = [
    biscuit-haskell log-base pg-entity
  ];
}
