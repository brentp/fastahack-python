=========
FastaHack
=========

python/cython wrapper for `fastahack`_ library

::

    >>> from fastahack import FastaHack
    >>> f = FastaHack('fastahack/tests/correct.fasta')
    >>> f.get_sub_sequence('1', 0, 10)
    'TAACCCTAACC'
    >>> f.get_sequence('1')[1:11]
    'AACCCTAACC'
    >>> f.get_sequence_length('1')
    630L
    >>> f.get_sequence_names()
    ['1', '2', '3']

Installation
------------
If `python setup.py install` gives an error, you may need to run 
`cython fastahack/cfastahack.pyx`


.. _`fastahack`: http://github.com/ekg/fastahack/
