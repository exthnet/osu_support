#!/bin/bash

function plot_init () {
	cat <<EOF > template.plt
#!gnuplot
set datafile separator ","
set key center top
set logscale y
set xtics rotate by 90
set xtics offset 0,-2.5
set bmargin 5
set xlabel "size"
set xlabel offset 0,-1.5
set ylabel "YLABEL"
set yrange[1:YMAX]
set label 1 at screen 0.20,0.80 "CAPTION"
set grid
set grid ytics mytics
plot   "FIN" using 2:xticlabels(1) with lp title "host"
replot "FIN" using 4:xticlabels(1) with lp title "cuda"
replot "FIN" using 6:xticlabels(1) with lp title "managed"
set terminal "png"
set out "FOUT"
replot
EOF
}

# main
plot_init

# latency
cmd="convert -append"
for n in 1n2p_1s 1n2p_2s 2n1p
do
	for k in latency
	do
        sed -i -e "s/,,/,0.0,0.0/g" log_${n}_${k}_all.csv
		sed -e "s/FIN/log_${n}_${k}_all.csv/" template.plt > template2.plt
		sed -e "s/FOUT/result_${n}_${k}.png/" template2.plt > template3.plt
		sed -e "s/CAPTION/${n} ${k}/" template3.plt > template4.plt
		sed -e "s/YLABEL/Latency (us)/" template4.plt > template5.plt
		sed -e "s/YMAX/100/" template5.plt > template6.plt
		gnuplot template6.plt
		cmd="${cmd} result_${n}_${k}.png"
	done
done
echo ${cmd} result_latency_all.png
${cmd} result_latency_all.png

# bandwidth
cmd="convert -append"
for n in 1n2p_1s 1n2p_2s 2n1p
do
	for k in bw
	do
        sed -i -e "s/,,/,0.0,0.0/g" log_${n}_${k}_all.csv
		sed -e "s/FIN/log_${n}_${k}_all.csv/" template.plt > template2.plt
		sed -e "s/FOUT/result_${n}_${k}.png/" template2.plt > template3.plt
		sed -e "s/CAPTION/${n} ${k}/" template3.plt > template4.plt
		sed -e "s/YLABEL/Bandwidth (MB\/s)/" template4.plt > template5.plt
		sed -e "s/YMAX/30000/" template5.plt > template6.plt
		gnuplot template6.plt
		cmd="${cmd} result_${n}_${k}.png"
	done
done
echo ${cmd} result_bw_all.png
${cmd} result_bw_all.png

# collective
cmd2="convert +append"
for n in 1 2 4
do
	cmd1="convert -append"
	for k in reduce allreduce reduce_scatter allgather bcast
	do
		sed -i -e "s/,,/,0.0,0.0/g" log_${n}n4p_${k}_all.csv
		sed -e "s/FIN/log_${n}n4p_${k}_all.csv/" template.plt > template2.plt
		sed -e "s/FOUT/result_${n}n4p_${k}.png/" template2.plt > template3.plt
		sed -e "s/CAPTION/${n}node(s) 4procs ${k}/" template3.plt > template4.plt
		sed -e "s/YLABEL/time (us)/" template4.plt > template5.plt
		sed -e "s/YMAX/1000/" template5.plt > template6.plt
		gnuplot template6.plt
		cmd1="${cmd1} result_${n}n4p_${k}.png"
	done
	for k in iallgather ibcast
	do
		sed -i -e "s/,,/,0.0,0.0/g" log_${n}n4p_${k}_all.csv
		sed -e "s/FIN/log_${n}n4p_${k}_all.csv/" template.plt > template2.plt
		sed -e "s/FOUT/result_${n}n4p_${k}.png/" template2.plt > template3.plt
		sed -e "s/CAPTION/${n}node(s) 4procs ${k}/" template3.plt > template4.plt
		sed -e "s/YLABEL/time (us)/" template4.plt > template5.plt
		sed -e "s/YMAX/1000/" template5.plt > template6.plt
		gnuplot template6.plt
		cmd1="${cmd1} result_${n}n4p_${k}.png"
	done
	echo ${cmd1} result_${n}_all.png
	${cmd1} result_${n}_all.png
	cmd2="${cmd2} result_${n}_all.png"
done
echo ${cmd2} result_all_all.png
${cmd2} result_all_all.png
