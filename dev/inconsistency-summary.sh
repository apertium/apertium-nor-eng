INC=$1
OUT=testvoc-summary.txt
POS="abbr adj adv cm cnjadv cnjcoo cnjsub det guio ij n np num pr preadv prn rel vaux vbhaver vblex vbser vbmod part"

echo "" > $OUT;

date >> $OUT
echo -e "===============================================" >> $OUT
echo -e "POS\tTotal\tClean\tWith @\tWith #\tClean %" >> $OUT
for i in $POS; do
	if [ "$i" = "det" ]; then
		TOTAL=`cat $INC | grep "<$i>" | grep -v -e '<n>' -e '<np>' -e '<adj>' -e '<num>' | grep -v REGEX | wc -l`; 
		AT=`cat $INC | grep "<$i>" | grep '@' | grep -v -e '<n>' -e '<np>'   -e '<adj>' -e '<num>' | grep -v REGEX | wc -l`;
		HASH=`cat $INC | grep "<$i>" | grep '>  *#' | grep -v -e '<n>' -e '<np>'  -e '<adj>' -e '<num>' | grep -v REGEX |  wc -l`;
	elif [ "$i" = "preadv" ]; then
		TOTAL=`cat $INC | grep "<$i>" | grep -v -e '<adj>' -e '<adv>' | grep -v REGEX | wc -l`; 
		AT=`cat $INC | grep "<$i>" | grep '@' | grep -v -e '<adj>' -e '<adv>'  | grep -v REGEX | wc -l`;
		HASH=`cat $INC | grep "<$i>" | grep '>  *#' | grep -v -e '<adj>' -e '<adv>' | grep -v REGEX |  wc -l`;
	elif [ "$i" = "adv" ]; then
		TOTAL=`cat $INC | grep "<$i>" | grep -v '<adj>' | grep -v -e '<v' -e REGEX | wc -l`; 
		AT=`cat $INC | grep "<$i>" | grep '@' | grep -v '<adj>'  | grep -v -e '<v' -e REGEX | wc -l`;
		HASH=`cat $INC | grep "<$i>" | grep '>  *#' | grep -v '<adj>' | grep -v -e '<v' -e REGEX |  wc -l`;
	elif [ "$i" = "num" ]; then
		TOTAL=`cat $INC | grep "<$i>" | grep -v -e '<det' -e REGEX | wc -l`; 
		AT=`cat $INC | grep "<$i>" | grep '@' | grep -v -e '<det' -e REGEX | wc -l`;
		HASH=`cat $INC | grep "<$i>" | grep '>  *#' | grep -v -e '<det' -e REGEX |  wc -l`;
	else
		TOTAL=`cat $INC | grep "<$i>" | grep -v REGEX | wc -l`; 
		AT=`cat $INC | grep "<$i>" | grep '@'  | grep -v REGEX | wc -l`;
		HASH=`cat $INC | grep "<$i>" | grep '>  *#' | grep -v REGEX |  wc -l`;
	fi
	UNCLEAN=`calc $AT+$HASH`;
	CLEAN=`calc $TOTAL-$UNCLEAN`;
	PERCLEAN=`calc $UNCLEAN/$TOTAL*100 |sed 's/^\W*//g' | sed 's/~//g' | head -c 5`;
	echo $PERCLEAN | grep "Err" > /dev/null;
	if [ $? -eq 0 ]; then
		TOTPERCLEAN="100";
	else
		TOTPERCLEAN=`calc 100-$PERCLEAN | sed 's/^\W*//g' | sed 's/~//g' | head -c 5`;
	fi

	echo -e $TOTAL";"$i";"$CLEAN";"$AT";"$HASH";"$TOTPERCLEAN;
done | sort -gr | awk -F';' '{print $2"\t"$1"\t"$3"\t"$4"\t"$5"\t"$6}' >> $OUT

echo -e "===============================================" >> $OUT
cat $OUT;
