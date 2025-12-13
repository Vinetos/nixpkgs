{
  lib,
  buildPythonPackage,
  fetchFromGitHub,

  # build-system
  setuptools,
  setuptools-scm,

  # dependencies
  numpy,
  iso8601,
  oslo-config,
  oslo-policy,
  oslo-middleware,
  oslo-utils,
  pytimeparse,
  pecan,
  jsonpatch,
  cotyledon,
  stevedore,
  ujson,
  voluptuous,
  werkzeug,
  tenacity,
  WebOb,
  Paste,
  PasteDeploy,
  daiquiri,
  pyparsing,
  lz4,
  tooz,
  cachetools,

  # optional deps
  keystonemiddleware,
      pymysql,
      oslo-db,
      sqlalchemy,
      sqlalchemy-utils,
      alembic,
      boto3,
      botocore,
    redis,
    hiredis,
    python-swiftclient,
    python-rados,
    python-snappy,
    protobuf,
    python-qpid-proton,
  # doc
  sphinx,
  furo,
  sphinxcontrib-httpdomain,
  PyYAML,
  Jinja2,
  reno,

 # tests
pifpaf, #pifpaf[gnocchi],
  gabbi,
  coverage,
  fixtures,
  python-subunit,
  stestr,
    testscenario,
    testresources,
    testtools,
    WebTest,
    wsgi_intercept,
    xattr,
}:

buildPythonPackage rec {
  pname = "gnocchi";
  version = "4.7.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "gnocchixyz";
    repo = "gnocchi";
    tag = version;
    hash = "";
  };

  build-system = [
    setuptools
    setuptools-scm
  ];

  dependencies = [
    numpy
    iso8601
    oslo-config
    oslo-policy
    oslo-middleware
    oslo-utils
    pytimeparse
    pecan
    jsonpatch
    cotyledon
    stevedore
    ujson
    voluptuous
    werkzeug
    tenacity
    WebOb
    Paste
    PasteDeploy
    daiquiri
    pyparsing
    lz4
    tooz
    cachetools
  ];

  optional-dependencies = {
    keystone = [ keystonemiddleware ];
    mysql = [
      pymysql
      oslo-db
      sqlalchemy
      sqlalchemy-utils
      alembic
    ];
    s3 = [
      boto3
      botocore
    ];
    redis = [
    redis
    hiredis
    ];
    swift = [ python-swiftclient ];
    ceph_alternative = [ python-rados ];
    prometheus = [ python-snappy protobuf ];
    amqp1 = [ python-qpid-proton ];
  };

  nativeBuildInputs = [
    sphinx
    furo
    sphinxcontrib-httpdomain
    PyYAML
    Jinja2
    reno
  ];

  nativeCheckInputs = [
    pifpaf#[gnocchi]
    gabbi
    coverage
    fixtures
    python-subunit
    stestr
    testscenario
    testresources
    testtools
    WebTest
    keystonemiddleware
    wsgi_intercept
    xattr
    python-swiftclient
  ] ++ lib.concatAttrValues optional-dependencies;

  pythonImportsCheck = [ "gnocchiclient" ];

  # NOTE(vinetos): gnocchi must have
  checkPhase = ''
    runHook preCheck

    echo to be determined

    runHook postCheck
  '';

  meta = with lib; {
    description = "Open-source time series database";
    homepage = "https://github.com/gnocchixyz/python-gnocchi";
    mainProgram = "gnocchi";
    license = licenses.asl20;
    teams = [ teams.openstack ];
  };
}
