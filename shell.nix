let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs { };
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
python.env
