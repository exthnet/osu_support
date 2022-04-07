#!/bin/bash -x
#PJM -L rscgrp=cx-small
#PJM -L node=2
#PJM -j
#PJM -S

eval `cat env.sh`

# 4 GPUs
for k in reduce allreduce reduce_scatter allgather bcast
do
	mpirun -machinefile $PJM_O_NODEINF -n 8 -map-by ppr:2:socket ./run_1.sh ./mpi/collective/osu_${k}               2>&1 | tee log_2n4p_${k}_host.txt
	mpirun -machinefile $PJM_O_NODEINF -n 8 -map-by ppr:2:socket ./run_1.sh ./mpi/collective/osu_${k} -d cuda       2>&1 | tee log_2n4p_${k}_cuda.txt
	mpirun -machinefile $PJM_O_NODEINF -n 8 -map-by ppr:2:socket ./run_1.sh ./mpi/collective/osu_${k} -d managed    2>&1 | tee log_2n4p_${k}_managed.txt
	mpirun -machinefile $PJM_O_NODEINF -n 8 -map-by ppr:2:socket ./run_1.sh ./nccl/collective/osu_nccl_${k} -d cuda 2>&1 | tee log_2n4p_${k}_nccl.txt
done

