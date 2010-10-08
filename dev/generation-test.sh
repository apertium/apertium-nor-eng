#!/bin/bash

if [[ $# -lt 1 ]]; then
	echo "Not enough arguments to generation-test.sh";
	echo "bash generation-test.sh <corpus>";
	exit;
fi

if [[ $1 == "-r" ]]; then
	if [[ $# -lt 2 ]]; then 
		echo $#;
		echo "Not enough arguments to generation-test.sh -r";
		echo "bash generation-test.sh -r <corpus>";
		exit;
	fi
	args=("$@")
	echo "Corpus in: "`dirname $2`;
	echo -n "Processing corpus for generation test... ";
	rm -f /tmp/no-en.corpus.txt
	for i in `seq 1 $#`; do 
		if [[ ${args[$i]} != "" && -f ${args[$i]} ]]; then 
			cat ${args[$i]} >> /tmp/no-en.corpus.txt
		fi
	done
	echo "done.";
	echo -n "Translating corpus for generation test (this could take some time)... ";
	cat /tmp/no-en.corpus.txt | apertium -d ../ no-en-postchunk-nocg | sed 's/\$\W*\^/$\n^/g' > /tmp/no-en.gentest.postchunk
	echo "done.";
fi

if [[ ! -f /tmp/no-en.gentest.postchunk ]]; then
	echo "Something went wrong in processing the corpus, you have no output file.";
	echo "Try running:"
	echo "   sh generation-test.sh -r <corpus>";
	exit;
fi

cat /tmp/no-en.gentest.postchunk  | sed 's/^ //g' | grep -v -e '@' -e '*' -e '[0-9]<num>' -e '#}' -e '#{' | sed 's/\$>/$/g' | sed 's/^\W*\^/^/g' | sort -f | uniq -c | sort -gr > /tmp/no-en.gentest.stripped
cat /tmp/no-en.gentest.stripped | grep -v '\^\W<' | lt-proc -d ../no-en.autogen.bin > /tmp/no-en.gentest.surface
cat /tmp/no-en.gentest.stripped | grep -v '\^\W<'  | sed 's/^ *[0-9]* \^/^/g' > /tmp/no-en.gentest.nofreq
paste /tmp/no-en.gentest.surface /tmp/no-en.gentest.nofreq  > /tmp/no-en.generation.errors.txt
cat /tmp/no-en.generation.errors.txt  | grep -v '#' | grep '\/' > /tmp/no-en.multiform
cat /tmp/no-en.generation.errors.txt  | grep '[0-9] #.*\/' > /tmp/no-en.multibidix 
cat /tmp/no-en.generation.errors.txt  | grep '[0-9] #' | grep -v '\/' > /tmp/no-en.tagmismatch 

echo "";
echo "===============================================================================";
echo "Multiple surface forms for a single lexical form";
echo "===============================================================================";
cat /tmp/no-en.multiform

echo "";
echo "===============================================================================";
echo "Multiple bidix entries for a single source language lexical form";
echo "===============================================================================";
cat /tmp/no-en.multibidix

echo "";
echo "===============================================================================";
echo "Tag mismatch between transfer and generation";
echo "===============================================================================";
cat /tmp/no-en.tagmismatch

echo "";
echo "===============================================================================";
echo "Summary";
echo "===============================================================================";
wc -l /tmp/no-en.multiform /tmp/no-en.multibidix /tmp/no-en.tagmismatch
