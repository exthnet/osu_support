osu-micro-benchmarks をまとめて実行するためのスクリプト群。
env.sh にmodule設定を書いて、bench.shを実行するだけで良い。
実行後はresult.shを実行すればグラフの生成まで行ってくれる。
測定対象を調整したい場合は各shファイルを調整すること。

# 実例
- flow_type2
  - 名古屋大学情報基盤センター「不老」Type II用

## 含まれているファイル
- bench.sh
  - まとめて実行してくれるスクリプト。
- run_1.sh, run_2.sh
  - プロセス割り当て補助用スクリプト。
- result.sh
  - グラフ作成用までやってくれるスクリプト。
- result_1.sh, result_2.sh
   - result.shから呼び出されるスクリプト。

- env.sh
  - 環境設定用スクリプト。module load等を書く。
  - evalしている都合上、複数行書きたい場合は各行に ; が必要なはず。
```
 module load hogehoge;
 export env=hogehoge;
```

以下、bench.shから呼ばれる具体的なジョブスクリプト

- 1ノード内2プロセスp2p
  - job_1n2p_p2p_bw.sh
  - job_1n2p_p2p_latency.sh

- 2ノード間p2p
  - job_2n1p_p2p_bw.sh
  - job_2n1p_p2p_latency.sh

- 1ノード内4プロセス集団通信
  - job_1n4p_col.sh
  - job_1n4p_icol.sh

- 2ノード*4プロセス集団通信
  - job_2n4p_col.sh
  - job_2n4p_icol.sh

- 4ノード*4プロセス集団通信
  - job_4n4p_col.sh
  - job_4n4p_icol.sh


# memo
nccl有効化ビルドのconfigureははこんな感じ？

```
$ ../configure --enable-cuda -enable-ncclomb --prefix=`pwd` CC=mpicc CXX=mpicxx
```

オプションが足りなくて通らない場合はこんな感じか？

```
$ ../configure --enable-cuda -enable-ncclomb --prefix=`pwd` CC=mpicc CXX=mpicxx --includedir=$CPATH --with-nccl=/home/center/opt/x86_64/apps/cuda/11.6.2/nccl/2.12.7
```
