#!/bin/bash
set +x

# Install NVIDIA driver
add-apt-repository -y ppa:graphics-drivers \
 && apt-get update -y \
 && apt-get install nvidia-375 -y \
 && apt-mark hold nvidia-375 -y

# Install Ethereum
apt-get install software-properties-common -y \
 && add-apt-repository -y ppa:ethereum/ethereum \
 && apt-get update -y \
 && apt-get install ethereum -y

# Download and install CUDA
mkdir /ethereum \
 && cd /ethereum \
 && wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_8.0.61-1_amd64.deb \
 && dpkg -i cuda-repo-ubuntu1604_8.0.61-1_amd64.deb

# Install required dependencies
apt-get install \
 vim git cmake libcryptopp-dev libleveldb-dev libjsoncpp-dev \
 libjsonrpccpp-dev libboost-all-dev libgmp-dev libreadline-dev \
 libcurl4-gnutls-dev ocl-icd-libopencl1 opencl-headers golang-go \
 mesa-common-dev libmicrohttpd-dev build-essential cuda -y

# Download and compile ethminer
 rm -rf /ethereum/genoil-ethereum \
 && git clone https://github.com/nanopool/genoil-ethereum.git /ethereum/genoil-ethereum \
 && cd /ethereum/genoil-ethereum \
 && mkdir build \
 && cd build \
 && cmake -DBUNDLE=cudaminer -DETHASHCUDA=ON .. \
 && make -j8

ln -s /ethereum/genoil-ethereum/build/ethminer/ethminer /usr/local/sbin
