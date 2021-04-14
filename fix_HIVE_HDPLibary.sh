#!/bin/bash
#FAILED: Execution Error, return code -101 from org.apache.hadoop.hive.ql.exec.mr.MapRedTask. DEFAULT_MR_AM_ADMIN_USER_ENV
#此错误是tez 中hadoop包与hadoop 版本包不一致导致
sudo rm /opt/apache-tez-0.9.2-bin/lib/hadoop-mapreduce-c*
sudo cp /opt/hadoop-2.10.1/share/hadoop/mapreduce/hadoop-mapreduce-client-co* /opt/apache-tez-0.9.2-bin/lib/
