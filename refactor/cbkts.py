#!/data/data/com.termux/files/usr/bin/python3

import sys
import os
import re

fname1 = str( sys.argv[1] )
fname2 = str( sys.argv[2] )
f1 = open( str(fname1), "r", encoding="utf8" )
f2 = open( str(fname2), "w", encoding="utf8" )

rgx = r'\)\s*\{\s*$'
re.compile( rgx, re.MULTILINE )

s = f1.read()
while ( re.search( rgx, s )):
  s = rgx.replace( s, '\r{' )

f2.write(s)
f1.close();
f2.close();
