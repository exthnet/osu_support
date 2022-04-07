#!/bin/bash -x
#PJM -L rscgrp=cx-small
#PJM -L node=2
#PJM -j
#PJM -S

eval `cat env.sh`

mpirun -machinefile $PJM_O_NODEINF -n 2 -map-by ppr:1:node ./run_1.sh ./mpi/pt2pt/osu_bw H H       2>&1 | tee log_2n1p_bw_host.txt
mpirun -machinefile $PJM_O_NODEINF -n 2 -map-by ppr:1:node ./run_1.sh ./mpi/pt2pt/osu_bw D D       2>&1 | tee log_2n1p_bw_cuda.txt
mpirun -machinefile $PJM_O_NODEINF -n 2 -map-by ppr:1:node ./run_1.sh ./nccl/pt2pt/osu_nccl_bw D D 2>&1 | tee log_2n1p_bw_nccl.txt

