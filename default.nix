{ pkgs ? import (import ./nix/sources.nix).nixpkgs { } }:

let
  lexicon = ps: ps.callPackage ./lexicon.nix { };
  certbot-dns-namecheap = ps: ps.callPackage ./certbot-dns-namecheap.nix { lexicon = (lexicon ps); };
  python = pkgs.python3.withPackages (p: with p; [
    certbot
    acme
    mock
    pynamecheap
    setuptools
    (certbot-dns-namecheap p)
  ]);
in
{
  inherit lexicon certbot-dns-namecheap;
  python-certbot = python;
}
