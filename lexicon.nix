{ lib
, buildPythonPackage
, pytestCheckHook
, fetchPypi
, isPy3k
, poetry-core
, beautifulsoup4
, tldextract
, requests
, pyyaml
, cryptography
, pytest-vcr
, vcrpy
}:

buildPythonPackage rec {
  pname = "dns-lexicon";
  version = "3.8.4";
  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    sha256 = "1cnbwzsf38hhl0pq5pyi35jhq0z99s2b52pfisdpz587jl4680xx";
  };

  nativeBuildInputs = [ poetry-core ];

  propagatedBuildInputs = [ beautifulsoup4 tldextract pyyaml requests cryptography ];

  # Tests are failing for some reason...
  # checkInputs = [ pytestCheckHook pytest-vcr vcrpy ];

  doCheck = isPy3k;

  pythonImportsCheck = [
    "lexicon"
  ];

  meta = with lib; {
    description = "Manipulate DNS records on various DNS providers in a standardized/agnostic way.";
    homepage = "https://github.com/AnalogJ/lexicon";
    license = licenses.mit;
  };
}
