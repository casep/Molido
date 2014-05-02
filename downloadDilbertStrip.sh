#!/bin/bash
#FU RSS
#Carlos Sepulveda, casep@fedoraproject.org
#20130628, Casep, Initial Release
#Requires links installed
#Assumes the image is something like
#http://dilbert.com/dyn/str_strip/000000000/00000000/0000000/100000/80000/8000/700/188736/188736.strip.gif
#also assume that the image id is not repeated, so only saving the last part "188736.strip.gif" for each

today=$(date +%F)
yesterday=$(date -d "$today -1 days" +%F)
folder=$1
image=$(links -source http://dilbert.com/strips/comic/$today | grep "img src" |  grep "strip.gif" | cut -d "<" -f4 | cut -d"\"" -f2)
wget $image -P $folder/ 
file=$(echo $image | cut -d"/" -f14)
echo "<html><title>Today's Dilbert</title><img src=\"$file\"><br><a href=\"http://dilbert.com/strips/comic/$today\">Source</a><br><a href=\"$yesterday.html\">Previous</a></html>" > $folder/$today.html
ln -s $folder/index.html $folder/$today.html
