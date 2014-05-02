#!/usr/bin/python
import commands
import sys

estado = commands.getoutput('cat output.txt')

print estado[-1:]

if estado[-1:] == "1":
 print "FOP OK: Respuesta 0.5 Seg | Respuesta FOP 0.5 Seg."
 sys.exit(0)
else:
 print "FOP CRITICAL: FOP No responde | FOP No responde"
 sys.exit(2)

