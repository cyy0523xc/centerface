# Pull base image.
# Dockerfile: https://github.com/IBBD/dockerfile-tensorflow/blob/master/cuda/cuda101-cudnn7-py36-ubuntu1804.Dockerfile
FROM registry.cn-hangzhou.aliyuncs.com/ibbd/cuda:cuda101-cudnn7-py36-ubuntu1804

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# install opencv
# https://docs.opencv.org/4.1.2/d7/d9f/tutorial_linux_install.html
# Unable to locate package libjasper-dev
ENV cvVersion 4.1.2
RUN apt-get update -y \
    # compiler
    && apt-get install -y --no-install-recommends \
        build-essential \
    # required
    && apt-get install -y --no-install-recommends \
        cmake \
        wget \
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
        #libjasper-dev \
        libdc1394-22-dev \
    # install numpy
    && python3 -m pip install -U setuptools \
    && python3 -m pip --no-cache-dir install \
        numpy \
    # install opencv4
    && mkdir /src \
    && cd /src \
    && wget https://github.com/opencv/opencv/archive/$cvVersion.tar.gz -O opencv.tar.gz \
    && wget https://github.com/opencv/opencv_contrib/archive/$cvVersion.tar.gz -O opencv_contrib.tar.gz \
    && tar -zxf opencv.tar.gz \
    && tar -zxf opencv_contrib.tar.gz \
    && rm opencv.tar.gz \
    && rm opencv_contrib.tar.gz \
    && cd opencv \
    && mkdir build \
    && cd build \
    && cmake -D CMAKE_BUILD_TYPE=Release \
        -D OPENCV_EXTRA_MODULES_PATH=/src/opencv_contrib/modules \
        -D CMAKE_INSTALL_PREFIX=/usr/local \
        .. \
    && make -j7 \
    && make install \
    # clear 
    && apt-get remove -y \
        build-essential \
        cmake \
        wget \
    && rm -rf /var/lib/apt/lists/* \
