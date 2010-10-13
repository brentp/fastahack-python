python setup.py build_ext -i
nosetests --with-doctest --doctest-extension=.pyx fastahack/cfastahack.pyx
PYTHONPATH=. python fastahack/tests/test_all.py
