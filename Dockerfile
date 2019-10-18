# Pull base image.
# Dockerfile: https://github.com/IBBD/dockerfile-tensorflow/blob/master/cuda/cuda101-cudnn7-py36-ubuntu1804.Dockerfile
FROM registry.cn-hangzhou.aliyuncs.com/ibbd/cuda:cuda101-cudnn7-py36-ubuntu1804

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# 安装基础库, opencv
RUN apt-get update -y \
    # compiler
    && apt-get install -y --no-install-recommends \
        build-essential \
    # required
    && apt-get install -y --no-install-recommends \
        cmake \
        git \
        libgtk2.0-dev \
        pkg-config \
        libavcodec-dev \
        libavformat-dev \
        libswscale-dev \
    # required
    && apt-get install -y --no-install-recommends \
        libtbb2 \
        libtbb-dev \
        libjpeg-dev \
        libpng-dev \
        libtiff-dev \
        libjasper-dev \
        libdc1394-22-dev \
    # install numpy
    && python3 -m pip install -U setuptools \
    && python3 -m pip --no-cache-dir install \
        numpy \
    # install opencv4
    && mkdir /src \
    && cd /src \
    && git clone https://github.com/opencv/opencv.git \
    && git clone https://github.com/opencv/opencv_contrib.git \
    && cd opencv \
    && mkdir build \
    && cd build \
    && cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local .. \
    && make -j7 \
    && make install \
    # clear 
    && apt-get remove -y \
        build-essential \
        cmake \
    && rm -rf /var/lib/apt/lists/* \
