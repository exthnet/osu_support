#!/bin/bash

for n in 1n2p_1s 1n2p_2s 2n1p
do
	for k in bw latency
	do
		cmd="paste -d ,"
		for d in host cuda
		do
			grep -v -e "^#\|^$" log_${n}_${k}_${d}.txt | sed -e "s/ \+/,/g" > log_${n}_${k}_${d}.csv
			cmd="${cmd} log_${n}_${k}_${d}.csv"
		done
		$cmd > log_${n}_${k}_all.csv
	done
done

for n in 1 2 4
do
	for k in reduce allreduce reduce_scatter allgather bcast
	do
		cmd="paste -d ,"
		for d in host cuda managed
		do
			grep -v -e "^#\|^$" log_${n}n4p_${k}_${d}.txt | sed -e "s/ \+/,/g" > log_${n}n4p_${k}_${d}.csv
			cmd="${cmd} log_${n}n4p_${k}_${d}.csv"
		done
		$cmd > log_${n}n4p_${k}_all.csv
	done

	for k in iallgather ibcast
	do
		cmd="paste -d ,"
		for d in host cuda managed
		do
			grep -v -e "^#\|^$" log_${n}n4p_${k}_${d}.txt | awk '{print $1,$2}' | sed -e "s/ \+/,/g" > log_${n}n4p_${k}_${d}.csv
			cmd="${cmd} log_${n}n4p_${k}_${d}.csv"
		done
		$cmd > log_${n}n4p_${k}_all.csv
	done
done
