#!/bin/sh
#Parse pButtons file, create multiple files from pButtons
#Casep, casep@intersystems.com
#2012-02-27, Casep, initial release
#2012-02-29, Casep, Mgstat

#1 pButtons file
if [ $# -lt 1 ]; then
 echo "usage parse_pButtons.sh pButtons_file.html"
 exit
fi

pButtons=$1
trailName=`echo $pButtons | cut -d"." -f1`
vmstat_filename=vmstat_$trailName
mgstat_filename=mgstat_$trailName

#does it looks like a pButtons file?
beg_vmstat=`grep beg_vmstat $pButtons | wc -l`
if [ $beg_vmstat -lt 1 ]; then
 echo "The file doesn't looks like a pButtons file"
 exit
fi

pButtons_length=`cat $pButtons | wc -l`

beg_vmstat=`grep -n beg_vmstat $pButtons | cut -d":" -f1`
end_vmstat=`grep -n end_vmstat $pButtons | cut -d":" -f1`
vmstat_length=`expr $end_vmstat - $beg_vmstat - 1`
from_vmstat=`expr $pButtons_length - $beg_vmstat + 1`
tail -n $from_vmstat $pButtons | head -n $vmstat_length | tr -s [:blank:] , > $vmstat_filename.csv

beg_mgstat=`grep -n beg_mgstat $pButtons | cut -d":" -f1`
end_mgstat=`grep -n end_mgstat $pButtons | cut -d":" -f1`
mgstat_length=`expr $end_mgstat - $beg_mgstat - 1`
from_mgstat=`expr $pButtons_length - $beg_mgstat + 1`
tail -n $from_mgstat $pButtons | head -n $mgstat_length | tr -s [:blank:] , > $mgstat_filename.csv

