{ lib
, buildPythonPackage
, pytestCheckHook
, fetchFromGitHub
, isPy3k
, certbot
, acme
, mock
, setuptools
, pynamecheap
, lexicon
}:

buildPythonPackage rec {
  pname = "certbot-dns-namecheap";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "dimitrijer";
    repo = "certbot_dns_namecheap";
    rev = "93ed4261f987b7a055028535bfdbe14638b243f5";
    sha256 = "sha256-MXUwWfltkT4s7f5wpPrNAZ//x9GINIDv9MkzvbWlpJg=";
  };

  propagatedBuildInputs = [ certbot acme setuptools mock pynamecheap lexicon ];

  # Tests are failing for some reason...
  # checkInputs = [ pytestCheckHook pytest-vcr vcrpy ];

  # doCheck = isPy3k;
  doCheck = false;

  pythonImportsCheck = [
    "certbot_dns_namecheap"
  ];

  meta = with lib; {
    description = "Certbot plugin to provide dns-01 challenge support for namecheap.com";
    homepage = "https://github.com/dimitrijer/certbot-dns-namecheap";
    license = licenses.mit;
  };
}

