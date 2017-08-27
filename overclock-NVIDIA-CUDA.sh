#!/bin/bash
set +x

read -p "Number of NVIDIA GPUs: " gpu_count
read -p "GPUMemoryTransferRateOffset [E.g. 800]: " GPUMemoryTransferRateOffset

for i in $(seq 0 $gpu_count)
do
  echo "Overclocking card #$i and setting GPUMemoryTransferRateOffset to $GPUMemoryTransferRateOffset";
  nvidia-settings -c :0 -a [gpu:$i]/GPUMemoryTransferRateOffset[3]=$GPUMemoryTransferRateOffset
done
