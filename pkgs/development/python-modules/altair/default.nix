{ lib
, buildPythonPackage
, fetchFromGitHub
, pythonOlder

# Run dependencies
, hatchling
, toolz
, numpy
, jsonschema
, typing-extensions
, pandas
, jinja2
, importlib-metadata

# Build, dev and test dependencies
, ipython
, pytestCheckHook
, vega_datasets
, black
, sphinx
}:

buildPythonPackage rec {
  pname = "altair";
  version = "5.0.1";
  format = "pyproject";
  disabled = pythonOlder "3.7";

  # We use fetch from Github because the Pypi is missing the tests
  src = fetchFromGitHub {
    owner = "altair-viz";
    repo = "altair";
    rev = "refs/tags/v${version}";
    hash = "sha256-7bTrfryu4oaodVGNFNlVk9vXmDA5/9ahvCmvUGzZ5OQ=";
  };

  propagatedBuildInputs = [
    jinja2
    jsonschema
    numpy
    pandas
    toolz
  ] ++ lib.optionals (pythonOlder "3.8") [ importlib-metadata ]
    ++ lib.optionals (pythonOlder "3.11") [ typing-extensions ];

  nativeCheckInputs = [
    hatchling
    black
    ipython
    sphinx
    vega_datasets
    pytestCheckHook
  ];

  pythonImportsCheck = [ "altair" ];

  disabledTestPaths = [
      "tests/test_examples.py" # Disabled because it uses network
      "tests/vegalite/v5/test_api.py" # TODO: Disabled because of missing altair_viewer package
  ];

  meta = with lib; {
    description = "A declarative statistical visualization library for Python.";
    homepage = "https://altair-viz.github.io";
    license = licenses.bsd3;
    maintainers = with maintainers; [ teh ];
    platforms = platforms.unix;
  };

}
