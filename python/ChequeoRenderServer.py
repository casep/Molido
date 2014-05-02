#!/usr/bin/python
#Revisa numero de procesos fop/renderserver en ejeucion en la maquina
#casep@fedoraproject.org, 20110318

import commands
import sys
#import smtplib
#import syslog

procesos = int(commands.getoutput('ps -fea | grep -i bash | wc -l'))

print "numero de procesos "
print procesos
print " "

if procesos == 0:
 print "Numero de procesos = 0"
 sys.exit(2)
elif procesos < 4:
 print"Numero de procesos entre 1 y 3"
 sys.exit(0)
elif procesos < 8:
 print "Numero de procesos entre 4 y 8"
 sys.exit(1)
else: 
 print "Numero de procesos mayor que 8"
 sys.exit(2)
