#!/bin/bash -x
#PJM -L rscgrp=cx-small
#PJM -L node=2
#PJM -j
#PJM -S

eval `cat env.sh`

mpirun -machinefile $PJM_O_NODEINF -n 2 -map-by ppr:1:node ./run_1.sh ./mpi/pt2pt/osu_latency H H       2>&1 | tee log_2n1p_latency_host.txt
mpirun -machinefile $PJM_O_NODEINF -n 2 -map-by ppr:1:node ./run_1.sh ./mpi/pt2pt/osu_latency D D       2>&1 | tee log_2n1p_latency_cuda.txt
mpirun -machinefile $PJM_O_NODEINF -n 2 -map-by ppr:1:node ./run_1.sh ./nccl/pt2pt/osu_nccl_latency D D 2>&1 | tee log_2n1p_latency_nccl.txt

