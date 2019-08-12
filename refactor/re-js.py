#!/usr/bin/env python3

import sys
import re

# get file names
infname = str( sys.argv[1] )
outfname = str( sys.argv[2] )

# open files
inF = open( str(infname), 'r', encoding='utf8' )
outF = open( str(outfname), 'w', encoding='utf8' )

# perform substitution
s = inF.read()
s = re.sub( r'(^\s*)(\S.*)(\)\s*\{\s*$)(?m)', r'\1\2)\n\1{', s )
s = re.sub( r'\s+=', r' =', s )
s = re.sub( r'for', r'while', s )

# write the new file
outF.write( s )

# save and close
inF.close();
outF.close();
