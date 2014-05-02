#!/usr/bin/perl 

# Cheap and nasty extractor for pButtons - mgstat specfic

# usage exaple:
# cat P570A_CACHE_20110418_0030_day.html | ./exmgstat.pl > P570A_CACHE_20110418_0030_day.mgstat.csv
# or:
# ./exmgstat.pl < P570A_CACHE_20110418_0030_day.html > P570A_CACHE_20110418_0030_day.mgstat.csv
# or for a list of files: 
# for i in $(ls *.html); do ./exmgstat.pl < ${i} > ${i}.mgstat.csv ; done


$foundMgstat=0;
$printIt=0;

while (<>) {
if (/beg_mgstat/) {
		$foundMgstat=1;
 	}

# Look for first actual line
if (($foundMgstat==1) && (/Date,/)) {
		$printIt=1;
 	}
 
 # No more mgstat	
 if (/end_mgstat/) {
 		$printIt=0;
 	}

 if ($printIt==1) {
  		print;
 	}

}

# Examples
#  	if (/12\/08\/2009\,11:03/) {
#	 	if (/12\/08\/2009\,12:03/) {
