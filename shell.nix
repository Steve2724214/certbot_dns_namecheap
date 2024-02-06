let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs { };
  lexicon = ps: ps.callPackage ./lexicon.nix { };
  python = pkgs.python3.withPackages (p: with p; [
    certbot
    acme
    mock
    pynamecheap
    (lexicon p)
    pip
  ]);
in
python.env
