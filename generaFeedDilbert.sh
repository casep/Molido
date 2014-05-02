#!/bin/bash
#FU RSS
#Carlos Sepulveda, casep@fedoraproject.org
#20130628, Casep, Initial Release
#Requires links installed
#Assumes the image is something like
#http://dilbert.com/dyn/str_strip/000000000/00000000/0000000/100000/80000/8000/700/188736/188736.strip.gif


today=$(date +%F)
folder=$1
image=$(links -source http://dilbert.com/strips/comic/$today | grep "img src" |  grep "strip.gif" | cut -d "<" -f4 | cut -d"\"" -f2)
echo "<item><title>$today</title><description><![CDATA[<html><head><title>Dilbert for $today</title></head><body><img src=\"$image\"></body></html>]]></description><link>http://dilbert.com/strips/comic/$today</link></item>" > $folder/dilbert_$today
echo "<?xml version=\"1.0\"?><rss version=\"2.0\"><channel><title>Yet another Dilbert feed</title><description>FU new RSS feed</description><link>http://dilbert.com</link>" > $folder/feed.xml
cat $folder/dilbert_* >> $folder/feed.xml
echo "</channel></rss>" >> $folder/feed.xml


