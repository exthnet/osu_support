#!/bin/bash -x
#PJM -L rscgrp=cx-single
#PJM -j
#PJM -S

eval `cat env.sh`

# 4 GPUs
for k in iallgather ibcast ireduce iallreduce
do
	mpirun -n 4 -map-by ppr:2:socket ./run_1.sh ./mpi/collective/osu_${k} 2>&1            | tee log_1n4p_${k}_host.txt
	mpirun -n 4 -map-by ppr:2:socket ./run_1.sh ./mpi/collective/osu_${k} -d cuda 2>&1    | tee log_1n4p_${k}_cuda.txt
	mpirun -n 4 -map-by ppr:2:socket ./run_1.sh ./mpi/collective/osu_${k} -d managed 2>&1 | tee log_1n4p_${k}_managed.txt
done

