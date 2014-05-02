#!/bin/bash
# script that checks warnings in cconsole.log
#

#msg=`/usr/bin/python /home/casep/devel/parse/parse.py $1 $2|grep SIGDANGER`
msg=`/usr/bin/python /home/casep/devel/parse/parse.py $1 $2`

result=`echo $msg | cut -d":" -f1` 
if [ "$result" = "SIGDANGER ALERT" ]; then
  echo $msg
  exit 2
else if [ "$result" = "PARSE ERROR" ]; then
       echo $msg
       exit 1
     else
       echo "SIGDANGER OK"
       exit 0  
    fi
fi

