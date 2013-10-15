SOFT-DELIMITERS = "<,>" cm ;
DELIMITERS = "<.>" "<:>" "<!>" "<?>" "<|>" "<$.>" "<$:>" "<$!>" "<$?>" "<$|>" sent ;

LIST Comp = (comp);
LIST CLB = (clb);
LIST PPart = (pp);

SECTION

SUBSTITUTE ("tidlig") ("tidlig:1") ("tidlig" adj) (0 Comp);

SUBSTITUTE ("nød") ("nød:4") ("nød" n) (0 ("\+[a-z]+"r));

# Note: This should look for 'penge' as an @OBJ when we get the syntax labelling
SUBSTITUTE ("tjene") ("tjene:2") ("tjene" vblex) (1* ("penge" pl) BARRIER CLB);
	## Jeg må skifte jobb fordi jeg ikke tjener nok penger nå.

SUBSTITUTE ("bli") ("bli:1") ("bli" vblex) (1 PPart LINK 1 ("av"));
	## Men i 1989 forlot nesten alle cubanerne landet etter en fredsavtale ble signert av Angola, Cuba og Sør-Afrika.

SUBSTITUTE ("av") ("av:1") ("av" pr) (-1 PPart LINK -1 ("bli:1" vblex));
	## Men i 1989 forlot nesten alle cubanerne landet etter en fredsavtale ble signert av Angola, Cuba og Sør-Afrika.
