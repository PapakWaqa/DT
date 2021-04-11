#!/bin/bash
sudo rm /opt/apache-tez-0.9.2-bin/lib/hadoop-mapreduce-c*
sudo cp /opt/hadoop-2.10.1/share/hadoop/mapreduce/hadoop-mapreduce-client-co* /opt/apache-tez-0.9.2-bin/lib/
