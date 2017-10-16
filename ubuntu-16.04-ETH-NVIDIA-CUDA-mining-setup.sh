#!/bin/bash
set +x

# Remove older NVIDIA driver
apt -y purge nvidia*

# Autoremove
apt -y autoremove

# Install NVIDIA driver
add-apt-repository -y ppa:graphics-drivers \
 && apt -y update \
 && apt -y install nvidia-384

# Install Ethereum
apt install -y software-properties-common \
 && add-apt-repository -y ppa:ethereum/ethereum \
 && apt -y update \
 && apt -y install ethereum

# Download and install CUDA 8
mkdir -p /ethereum \
 && cd /ethereum \
 && wget -N https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_8.0.61-1_amd64.deb \
 && dpkg -i cuda-repo-ubuntu1604_8.0.61-1_amd64.deb

# Install required dependencies
apt -y install \
 vim git cmake libcryptopp-dev libleveldb-dev libjsoncpp-dev \
 libjsonrpccpp-dev libboost-all-dev libgmp-dev libreadline-dev \
 libcurl4-gnutls-dev ocl-icd-libopencl1 opencl-headers golang-go \
 mesa-common-dev libmicrohttpd-dev build-essential cuda

# Download and compile nanopool ethminer
#rm -rf /ethereum/genoil-ethereum \
# && git clone https://github.com/nanopool/genoil-ethereum.git /ethereum/genoil-ethereum \
# && cd /ethereum/genoil-ethereum \
# && mkdir build \
# && cd build \
# && cmake -DBUNDLE=cudaminer -DETHASHCUDA=ON .. \
# && make -j8

#if [ ! -L /usr/local/sbin/ethminer ]; then
#  ln -s /ethereum/genoil-ethereum/build/ethminer/ethminer /usr/local/sbin
#fi

cd /ethereum \
 && wget -N "https://github.com/ethereum-mining/ethminer/releases/download/v0.12.0/ethminer-0.12.0-Linux.tar.gz" \
 && tar -zxvf ethminer-0.12.0-Linux.tar.gz

cp /ethereum/bin/ethminer /usr/local/sbin
chmod a+x /usr/local/sbin/ethminer
