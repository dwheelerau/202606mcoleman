#!/bin/bash  

# see this post for memory issues
# https://github.com/ablab/spades/issues/871#issuecomment-965639427
# also recommendation to lower the number of threads that are contrib to
# memory allocation issues

# adjusted down -t 100 to -t 24
# incrased -m from 500 to 700
#sudo sysctl -w vm.max_map_count=1048576
# but I used 4x initially
#sudo sysctl -w vm.max_map_count=262144
# this might not be retained after reboot

rnaspades.py \
  -1 adtrim/all_adtrimmed_R1.fastq.gz \
  -2 adtrim/all_adtrimmed_R2.fastq.gz \
  -t 24 \
  -m 700 \
  -o assembly/rnaspades_out
