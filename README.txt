osu-micro-benchmarks をまとめて実行するためのスクリプト群。
env.sh にmodule設定を書いて、bench.shを実行するだけで良い。
実行後はresult.shを実行すればグラフの生成まで行ってくれる。
測定対象を調整したい場合は各shファイルを調整すること。

1ノード内2プロセスp2p
job_1n2p_p2p_bw.sh
job_1n2p_p2p_latency.sh
2ノード間p2p
job_2n1p_p2p_bw.sh
job_2n1p_p2p_latency.sh

1ノード内4プロセス集団通信
job_1n4p_col.sh
job_1n4p_icol.sh

2ノード*4プロセス集団通信
job_2n4p_col.sh
job_2n4p_icol.sh

4ノード*4プロセス集団通信
job_4n4p_col.sh
job_4n4p_icol.sh



nccl有効化ビルドのconfigureははこんな感じ？
# $ ../configure --enable-cuda -enable-ncclomb --prefix=`pwd` CC=mpicc CXX=mpicxx --includedir=$CPATH --with-nccl=/home/center/opt/x86_64/apps/cuda/11.6.2/nccl/2.12.7
$ ../configure --enable-cuda -enable-ncclomb --prefix=`pwd` CC=mpicc CXX=mpicxx

