SOFT-DELIMITERS = "<,>" cm ;
DELIMITERS = "<.>" "<:>" "<!>" "<?>" "<|>" "<$.>" "<$:>" "<$!>" "<$?>" "<$|>" sent ;

LIST Comp = (comp);
LIST CLB = (clb);

SECTION

SUBSTITUTE ("tidlig") ("tidlig:1") ("tidlig" adj) (0 Comp);

SUBSTITUTE ("nød") ("nød:4") ("nød" n) (0 ("\+[a-z]+"r));

# Note: This should look for 'penge' as an @OBJ when we get the syntax labelling
SUBSTITUTE ("tjene") ("tjene:2") ("tjene" vblex) (1* ("penge" pl) BARRIER CLB);
	## Jeg må skifte jobb fordi jeg ikke tjener nok penger nå.
