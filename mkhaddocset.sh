#! /usr/bin/env nix-shell
# shellcheck shell=bash
#! nix-shell -i bash -p ghc haddocset

outputDirectory=haskell.docset
compiler="ghc-9.0.2" # FIXME read the version from elsewhere?

function addPath {
  local path="$1"
  local packageDirectory="$path/lib/$compiler/package.conf.d"
  if [ -d "$packageDirectory" ]
  then
    find "$packageDirectory" -name "*.conf" -exec haddocset -t "$outputDirectory" add -s {} +
  fi
}

function addPaths {
  while read -r path
  do
    addPath "$path"
  done
}

function addDerivation {
  nix-store -r "$1" | addPaths
}

function addDerivations {
  while read -r derivation
  do
    addDerivation "$derivation"
  done
}

function listDerivations {
  nix-store -q --requisites $(nix-instantiate "$1" -A "$2")
}

function index {
  listDerivations ./haddocset.nix "$1" | addDerivations
}

function setupDocset {
  if [ ! -d "$outputDirectory" ]
  then
    haddocset -t "$outputDirectory" create
    sed -i 's|<string>hackage</string>|<string>lts-19</string>|' haskell.docset/Contents/Info.plist
    cp -r ./description/. "$outputDirectory"
  fi
}

setupDocset
index clean
NIXPKGS_ALLOW_BROKEN=1 index broken
