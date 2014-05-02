#!/usr/bin/perl 

# Cheap and nasty extractor for pButtons - vmstat specfic
#Based on exmgstat.pl by Murray Oldfield
#20120905, Casep, casep@intersys.com, Initial Release

# usage exaple:
# cat P570A_CACHE_20110418_0030_day.html | ./exvmstat.pl > P570A_CACHE_20110418_0030_day.vmstat.csv
# or:
# ./exvmstat.pl < P570A_CACHE_20110418_0030_day.html > P570A_CACHE_20110418_0030_day.vmstat.csv
# or for a list of files: 
# for i in $(ls *.html); do ./exvmstat.pl < ${i} > ${i}.vmstat.csv ; done


$foundVmstat=0;
$printIt=0;

while (my $line = <>) {

if ($line =~ m/beg_vmstat/) {
		$foundVmstat=1;
 	}

# Look for first actual line
if ($foundVmstat==1 && $line =~ m/avm/) {
		$printIt=1;
 	}
 
 # No more vmstat	
 if ($line =~ m/end_vmstat/) {
 		$printIt=0;
 	}

 if ($printIt==1) {
		chomp($line);
  		$line=~s/\s{1,}/,/g;
		print substr $line,1;
		print "\n";
 	}

}

