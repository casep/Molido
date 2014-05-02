#! /bin/sh 
mo_name=$1
mo_column=$2
mo_col_name=$3

mo_avg=`awk '( NR > 1 ) {sum=sum+$'$mo_column'} END {printf "%d\n", sum/(NR-1)}' $1`

gnuplot << EOF
#Plot mgstat with gnuplot - output to svg

reset
plot "$mo_name" using $mo_column	#To get the max and min value
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
# set datafile separator "\t"

#
# mgstat
#
set terminal svg size 800,600
set size ratio 0.60
set output "$mo_name.$mo_col_name.svg"
set title "$mo_col_name\n$mo_name" tc lt 3

set format y "%'10.0f"

set xdata time
set timefmt "%H:%M:%S"
set xrange ["00:00:00":"23:59:59"]
set format x "%H:%M"

set xlabel "Time"
set ylabel "$mo_col_name"

plot "$mo_name" using 2:$mo_column with lines lt 1 title sprintf("Max=%'.0f",ymax) axes x1y1,\
"$mo_name" using (xmax+0.1*xlen):(\$$mo_column):(1.1*xlen)\
smooth unique with xerrorbars lt 1 title sprintf("Avg=%'.0f",$mo_avg) axes x1y1

EOF
