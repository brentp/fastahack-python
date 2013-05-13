set -ex
python setup.py build_ext -i
PYTHONPATH=. nosetests --with-doctest --doctest-extension=.pyx fastahack/cfastahack.pyx
PYTHONPATH=. nosetests --with-doctest --doctest-extension=.rst README.rst
PYTHONPATH=. python fastahack/tests/test_all.py
