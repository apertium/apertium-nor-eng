TMPDIR=/tmp
PAIR=no-en
DIX=/home/fran/source/apertium/trunk/apertium-nn-nb/apertium-nn-nb.nb.dix

lt-expand $DIX | grep -e ':<:' -e '\w:\w' | sed 's/:<:/%/g' | sed 's/:/%/g' | cut -f2 -d'%' |  sed 's/^/^/g' | sed 's/$/$ ^.<sent>$/g' | tee $TMPDIR/$PAIR.tmp_testvoc1.txt |
        apertium-pretransfer|
        apertium-transfer ../apertium-mk-en.mk-en.t1x  ../mk-en.t1x.bin  ../mk-en.autobil.bin |
        apertium-interchunk ../apertium-mk-en.mk-en.t2x  ../mk-en.t2x.bin |
        apertium-postchunk ../apertium-mk-en.mk-en.t3x  ../mk-en.t3x.bin  | tee $TMPDIR/$PAIR.tmp_testvoc2.txt |
        lt-proc -d ../mk-en.autogen.bin > $TMPDIR/$PAIR.tmp_testvoc3.txt
paste -d _ $TMPDIR/$PAIR.tmp_testvoc1.txt $TMPDIR/$PAIR.tmp_testvoc2.txt $TMPDIR/$PAIR.tmp_testvoc3.txt | sed 's/\^.<sent>\$//g' | sed 's/_/   --------->  /g'
