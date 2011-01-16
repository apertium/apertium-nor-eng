INPUT=/tmp/no-en.gentest.postchunk
DEV=/home/fran/source/apertium/incubator/apertium-no-en/dev/bidix/

echo "SECTION

SELECT (vblex);
SELECT (inf);" > /tmp/temp_cg ;

cg-comp /tmp/temp_cg /tmp/temp_cg.bin ;

cat $INPUT | grep '<vblex>' | grep '@' | cut -f2 -d'@' | cut -f1 -d'<' | sh ~/scripts/lowercase.sh | lt-proc $DEV/../../no-en.automorf.bin  | cg-proc /tmp/temp_cg.bin  | cut -f2- -d'/' | sed 's/<pres><p3><sg>//g' | grep '<vblex>' | cut -f1 -d'$' | sort -f | uniq -c | sort -gr  | grep -v '[0-9] $' > $DEV/pending_verbs.txt

cat $INPUT | grep '@' | grep '<adv>' | grep -v '<v' | sh ~/scripts/lowercase.sh  | sort -f | sed 's/^\W*\^/^/g' | sort -f | uniq -c | sort -gr  | grep -v '[0-9] $' > $DEV/pending_adverbs.txt

cat $INPUT | grep '@' | grep '<pr>' | grep -v '<v' | sh ~/scripts/lowercase.sh  | sed 's/[Ëë]//g' | sort -f | sed 's/^\W*\^/^/g' | sort -f | uniq -c | sort -gr  | grep -v '[0-9] $'  > $DEV/pending_prepositions.txt

cat $INPUT | grep '@' | grep '<adj>'  | sh ~/scripts/lowercase.sh  | sed 's/^\W*\^/^/g' | sort -f | uniq -c  | sort -gr  | grep -v '[0-9] $'  > $DEV/pending_adjectives.txt

cat $INPUT | grep '@' | grep '<n>'  | sed 's/<sg>//g' | sed 's/<pl>//g' | sh ~/scripts/lowercase.sh  | sed 's/^\W*\^/^/g' | sort -f | uniq -c  | sort -gr  | grep -v '[0-9] $'  > $DEV/pending_nouns.txt

cat $INPUT | grep '@' | grep '<prn>'  | sed 's/<sg>//g' | sed 's/<pl>//g' | sed 's/[Ëë]//g' | sh ~/scripts/lowercase.sh  | sed 's/^\W*\^/^/g' | sort -f | uniq -c  | sort -gr  | grep -v '[0-9] $'  > $DEV/pending_pronouns.txt

cat $INPUT | grep '@' | grep '<num>'  | sed 's/<sg>//g' | sed 's/<pl>//g' | sed 's/[Ëë]//g' | sh ~/scripts/lowercase.sh  | sed 's/^\W*\^/^/g' | sort -f | uniq -c  | sort -gr  | grep -v '[0-9] $' > $DEV/pending_numerals.txt

cat $INPUT | grep '@' | grep '<np>'  | sed 's/<sg>//g' | sed 's/<pl>//g' | sed 's/^\W*\^/^/g' | sort -f | uniq -c  | sort -gr  | grep -v '[0-9] $' > $DEV/pending_proper_nouns.txt

cat $INPUT | grep '@' | grep '<cnj'  | sed 's/<sg>//g' | sed 's/<pl>//g' |sed 's/[Ëë]//g' | sh ~/scripts/lowercase.sh | sed 's/^\W*\^/^/g' | sort -f | uniq -c  | sort -gr  | grep -v '[0-9] $' > $DEV/pending_conjunctions.txt

cat $INPUT | grep '@' | grep '<det>'  | sed 's/<sg>//g' | sed 's/<pl>//g' | sed 's/[Ëë]//g'  | sed 's/^\W*\^/^/g' | sort -f | uniq -c  | sort -gr  | grep -v '[0-9] $' > $DEV/pending_determiners.txt

cat bilingual-summary.txt

echo ""

wc -l $DEV/pending_* | sort -gr  > bilingual-summary.txt

cat bilingual-summary.txt
