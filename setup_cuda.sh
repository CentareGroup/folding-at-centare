####################
# If any nvidia drivers, remove
####################
sudo apt-get purge nvidia-*

####################
# Install NVIDIA CUDA Drivers
####################
CUDA_REPO_PKG=cuda-repo-ubuntu1804_10.2.89-1_amd64.deb
wget -O /tmp/${CUDA_REPO_PKG} http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/${CUDA_REPO_PKG}
sudo dpkg -i /tmp/${CUDA_REPO_PKG}
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub
sudo apt-get -y update
sudo apt-get -y install cuda cuda-drivers
rm -f /tmp/${CUDA_REPO_PKG}

export PATH=/usr/local/cuda-10.2/bin:/usr/local/cuda-10.2/NsightCompute-2019.1${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-10.2/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

####################
# Install OpenCL Drivers
####################
sudo apt-get update -y
sudo apt-get install -y ocl-icd-opencl-dev

