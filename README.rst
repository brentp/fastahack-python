=========
FastaHack
=========

python/cython wrapper for `fastahack`_ library
The c++ library, fastahack, reads `.fai files`_ files for an index,
as created by e.g. `samtools`_ and the fastahack commandline interface.
Currently, the index (chr => (position, line length)) is read
into memory.

::

    >>> from fastahack import FastaHack
    >>> f = FastaHack('fastahack/tests/correct.fasta')
    >>> f['1:1-10']
    'TAACCCTAAC'
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
.. _`samtools`: http://samtools.sourceforge.net/
.. _`.fai files`: http://biostar.stackexchange.com/questions/1496/can-you-please-tell-me-where-i-find-information-about-fai-file-format
