#! /bin/sh 
#Multiple invoke for plotting program
#Based on do_mgst.sh by Murray Oldfield
#20120905, Casep, casep@intersys.com, Initial Release
vm_name=$1

# Put whatever loops etc, but this is just straight call
# r,b,avm,fre,re,pi,po,fr,sr,cy,in,sy,cs,us,sy,id,wa,hr,mi,se

gnu_vms.sh $1 4 fre
gnu_vms.sh $1 14 us
gnu_vms.sh $1 15 sy
gnu_vms.sh $1 17 wa

