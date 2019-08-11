#!/usr/bin/env python3

import sys
import re

fname1 = str( sys.argv[1] )
fname2 = str( sys.argv[2] )
fname3 = '/mnt/c/Users/Lori/Desktop/pythonlog.txt'
f1 = open( str(fname1), 'r', encoding='utf8' )
f2 = open( str(fname2), 'w', encoding='utf8' )
# f3 = open( fname3, 'w', encoding='utf8' )

rgxS = r'\)\s*\{\s*$'
rgxO = re.compile( rgxS, re.MULTILINE )

s = f1.read()
# f3.write( str(re.search(rgx,s)) + '\n' )
# while ( re.search( rgx, s )):
s = re.sub( rgxO, ')\n{', s )

f2.write( s )

f1.close();
f2.close();
# f3.close();
