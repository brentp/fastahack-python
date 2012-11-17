import unittest
import os
import os.path as op

from fastahack import FastaHack

DIR = op.dirname(__file__)
FA = op.join(DIR, "correct.fasta")
FAI = op.join(DIR, "correct.fasta.fai")

class FastaHackTest(unittest.TestCase):
    def setUp(self):
        if op.exists(FAI): os.unlink(FAI)

    def test_open(self):
        f = FastaHack(FA)
        assert op.exists(FAI)

    def tearDown(self):
        if op.exists(FAI): os.unlink(FAI)


class FastaTestMore(FastaHackTest):
    def setUp(self):
        self.fa = FastaHack(FA)

    def test_query(self):
        self.assertEqual(self.fa.get_sub_sequence("1", 0, 4), "TAACC")
        self.assertEqual(self.fa.get_sequence("1:1-5"), "TAACC")

if __name__ == "__main__":
    unittest.main()
