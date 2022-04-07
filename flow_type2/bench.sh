#!/bin/bash
for f in \
	job_1n2p_p2p_bw.sh \
	job_1n2p_p2p_latency.sh \
	job_2n1p_p2p_bw.sh \
	job_2n1p_p2p_latency.sh \
	job_1n4p_col.sh job_1n4p_icol.sh \
	job_2n4p_col.sh job_2n4p_icol.sh \
	job_4n4p_col.sh job_4n4p_icol.sh
do
	pjsub $f
done
