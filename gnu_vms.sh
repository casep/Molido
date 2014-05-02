#! /bin/sh 
#Ploting vmstat numbers, currently tested for us, sy, wa
#Based on gnu_mgs.sh by Murray Oldfield
#20120905, Casep, casep@intersys.com, Initial Release

vm_name=$1
vm_column=$2
vm_col_name=$3

mo_avg=`awk '( NR > 1 ) {sum=sum+$'$vm_column'} END {printf "%d\n", sum/(NR-1)}' FS=',' $1`

gnuplot << EOF
#Plot mgstat with gnuplot - output to svg

reset
set datafile separator ","
plot "$vm_name" using 18:$vm_column
ymax=GPVAL_DATA_Y_MAX
ymin=GPVAL_DATA_Y_MIN
ylen=ymax-ymin
xmax=GPVAL_DATA_X_MAX
xmin=GPVAL_DATA_X_MIN
xlen=xmax-xmin

set decimal locale
set grid layerdefault   linetype -1 linecolor rgb "gray"  linewidth 0.200,  linetype -1 linecolor rgb "gray"  linewidth 0.200
set grid y
set ytics

set key
set key autotitle columnheader

#
# vmstat
#
set terminal svg size 800,600
set size ratio 0.60
set output "$vm_name.$vm_col_name.svg"
set title "$vm_col_name\n$vm_name" tc lt 3

set format y "%'10.0f"

set xdata time
set timefmt "%H:%M:%S"
set xrange ["00:00:00":"23:59:59"]
set format x "%H:%M"

set xlabel "Time"
set ylabel "$vm_col_name"

plot "$vm_name" using 18:$vm_column with lines lt 1 title sprintf("Max=%'.0f",ymax) axes x1y1,\
"$vm_name" using (xmax+0.1*xlen):(\$$vm_column):(1.1*xlen)\
smooth unique with xerrorbars lt 1 title sprintf("Avg=%'.0f",$mo_avg) axes x1y1

EOF
