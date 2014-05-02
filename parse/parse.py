#!/usr/bin/python
#cconsole.log processing
#Casep, casep@intersys.com 
#2010/12/27

import sys
import re
import os.path
###

USAGE = '''PARSE ERROR: ''' + (sys.argv[0]) + ''' logFile countLogFileName '''
###

def hasWarning(s):
   return s.find('SIGDANGER') != -1

def getLines():
    countFileName = sys.argv[2]
    if os.path.exists(countFileName):    
      f = open(countFileName)
      for line in f:
        return int(line)+1
      f.close()
    else:
      return 0

def saveLines(count):
    countFileName = sys.argv[2]
    f = open(countFileName,'w')
    f.write(str(count))
    f.close()

def processLog():
    start = getLines()

    logFileName = sys.argv[1]
    with open(logFileName) as f:
      finish = 0
      for line in f:
        if start <= finish:
          if hasWarning(line):
            print "SIGDANGER ALERT: " + line
            return finish
        finish += 1
      return finish
      
def main():
    if len(sys.argv) <= 2:
        print USAGE
        return 1

    saveLines(processLog())

if __name__ == '__main__':
        main()
