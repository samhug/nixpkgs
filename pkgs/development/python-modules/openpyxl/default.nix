{ lib
, buildPythonPackage
, fetchPypi
, pytest
, jdcal
, et_xmlfile
, lxml
}:

buildPythonPackage rec {
  pname = "openpyxl";
  version = "2.6.1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "9e4db4ee7aadd0ff7a814f7483b2d94e6b8d4f14dff780b023c5bdc94af54dd5";
  };

  checkInputs = [ pytest ];
  propagatedBuildInputs = [ jdcal et_xmlfile lxml ];

  postPatch = ''
    # LICENSE.rst is missing, and setup.cfg currently doesn't contain anything useful anyway
    # This should likely be removed in the next update
    rm setup.cfg
  '';

  # Tests are not included in archive.
  # https://bitbucket.org/openpyxl/openpyxl/issues/610
  doCheck = false;

  meta = {
    description = "A Python library to read/write Excel 2007 xlsx/xlsm files";
    homepage = https://openpyxl.readthedocs.org;
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ lihop sjourdois ];
  };
}