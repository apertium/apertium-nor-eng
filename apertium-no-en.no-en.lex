SOFT-DELIMITERS = "<,>" cm ;
DELIMITERS = "<.>" "<:>" "<!>" "<?>" "<|>" "<$.>" "<$:>" "<$!>" "<$?>" "<$|>" sent ;

LIST Comp = (comp);

SECTION

SUBSTITUTE ("tidlig") ("tidlig:1") ("tidlig" adj) (0 Comp);

SUBSTITUTE ("nød") ("nød:4") ("nød" n) (0 ("\+[a-z]+"r));
