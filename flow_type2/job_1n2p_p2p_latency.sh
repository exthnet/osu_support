#!/bin/bash -x
#PJM -L rscgrp=cx-single
#PJM -j
#PJM -S

eval `cat env.sh`

# 2 GPUs in 1 socket
mpirun -n 2 -map-by ppr:2:socket ./run_1.sh ./mpi/pt2pt/osu_latency H H       2>&1 | tee log_1n2p_1s_latency_host.txt
mpirun -n 2 -map-by ppr:2:socket ./run_1.sh ./mpi/pt2pt/osu_latency D D       2>&1 | tee log_1n2p_1s_latency_cuda.txt
mpirun -n 2 -map-by ppr:2:socket ./run_1.sh ./nccl/pt2pt/osu_nccl_latency D D 2>&1 | tee log_1n2p_1s_latency_nccl.txt
# 2 sockets
mpirun -n 2 -map-by ppr:1:socket ./run_2.sh ./mpi/pt2pt/osu_latency H H       2>&1 | tee log_1n2p_2s_latency_host.txt
mpirun -n 2 -map-by ppr:1:socket ./run_2.sh ./mpi/pt2pt/osu_latency D D       2>&1 | tee log_1n2p_2s_latency_cuda.txt
mpirun -n 2 -map-by ppr:1:socket ./run_2.sh ./nccl/pt2pt/osu_nccl_latency D D 2>&1 | tee log_1n2p_2s_latency_nccl.txt

