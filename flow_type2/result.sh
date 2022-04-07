#!/bin/bash -x

./result_1.sh
./result_2.sh
n=`pwd`
/bin/cp result_all_all.png ${n##*/}-collective.png
/bin/cp result_latency_all.png ${n##*/}-latency.png
/bin/cp result_bw_all.png ${n##*/}-bw.png
