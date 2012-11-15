from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext

setup(
  name = 'fastahack',
  ext_modules=[
    Extension("fastahack.cfastahack",
              sources=["fastahack/cfastahack.pyx", "lib/Fasta.cpp", "lib/split.cpp"],
              libraries=["stdc++"],
              include_dirs=["lib/"],
              language="c++"),
    ],
    package_data = {'lib': ['*.pyx', "*.c", "*.h", "README.rst"]},
    package_dir = {"fastahack": "fastahack"},
    cmdclass = {'build_ext': build_ext},
    packages = ['fastahack', 'fastahack.tests'],
    author = "Brent Pedersen",
    author_email="bpederse@gmail.com",
    #test_suite='nose.collector'
)
