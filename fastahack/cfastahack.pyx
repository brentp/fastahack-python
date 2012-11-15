### requires cython >= 0.17
### wraps: http://github.com/ekg/fastahack

from libcpp.vector cimport vector
from libc.string cimport strchr
from libc.stdlib cimport atoi

cdef extern from "<string>" namespace "std":
    cdef cppclass string:
        string()
        string(char *)
        char * c_str()

cdef list vec2list(vector[string] sv):
    cdef list l = []
    cdef size_t size, i
    size = sv.size()
    for i in range(size):
        l.append(sv.at(i).c_str())
    return l

cdef extern from "Fasta.h":
    cdef cppclass FastaIndex:
        vector[string] sequenceNames

    cdef cppclass FastaReference:
        FastaReference()
        FastaReference(string fasta_filename)
        string getSequence(string seq_name)
        string getSubSequence(string seq_name, int start, int length)
        long unsigned int sequenceLength(string seq_name)
        FastaIndex *index

cdef class FastaHack:
    """
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

    """
    cdef FastaReference *fasta_ptr

    def __init__(self, fasta_filename):
        self.fasta_ptr = new FastaReference(string(fasta_filename))

    def __dealloc__(self):
        del self.fasta_ptr

    def get_sub_sequence(self, char *seq_name, int start=-1, int end=-1):
        """
        >>> f.get_sub_sequence('1', 1, 10)
        'AACCCTAACC'

        """
        if start < 0:
            colon = strchr(seq_name, ':')
            dash = strchr(seq_name, '-')
            if colon is NULL or dash is NULL:
                raise ValueError("When not specifying start/end, use 'chr:start-stop' (e.g., '1:12350-23460')")
            colon[0] = 0
            dash[0] = 0
            start = atoi(colon + 1)-1
            end = atoi(dash + 1)-1

        cdef string sseq = self.fasta_ptr.getSubSequence(string(seq_name),
                                                         start,
                                                         # it expects len
                                                         end - start + 1)
        return sseq.c_str()

    def get_sequence(self, char *seq_name):
        """
        >>> f.get_sequence('1')[1:11]
        'AACCCTAACC'

        """
        cdef string sseq = self.fasta_ptr.getSequence(string(seq_name))
        return sseq.c_str()

    def get_sequence_length(self, char *seq_name):
        """
        >>> f.get_sequence_length('2')
        614L

        """
        return self.fasta_ptr.sequenceLength(string(seq_name))

    def get_sequence_names(self):
        """
        >>> f.get_sequence_names()
        ['1', '2', '3']

        """
        return vec2list(self.fasta_ptr.index.sequenceNames)
