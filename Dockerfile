FROM nvcr.io/nvidia/cuda:11.7.1-cudnn8-devel-ubuntu22.04

RUN DEBIAN_FRONTEND=noninteractive  apt-get update
RUN DEBIAN_FRONTEND=noninteractive  apt-get install -y pkg-config libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev \
    libgstreamer-plugins-bad1.0-dev gstreamer1.0-plugins-base \
    gstreamer1.0-plugins-good gstreamer1.0-plugins-bad \
    gstreamer1.0-plugins-ugly gstreamer1.0-libav gstreamer1.0-tools \
    gstreamer1.0-x gstreamer1.0-alsa gstreamer1.0-gl gstreamer1.0-gtk3 \
    gstreamer1.0-qt5 gstreamer1.0-pulseaudio libcairo2-dev libgirepository1.0-dev

RUN  DEBIAN_FRONTEND=noninteractive  apt-get install -y wget curl vim traceroute net-tools htop iftop iotop

RUN DEBIAN_FRONTEND=noninteractive  apt-get install -y python-is-python3 python3-pip python3-dev
RUN pip --version
RUN pip install -U pip

RUN mkdir /app
COPY install_pipeless.sh /app 
WORKDIR /app
RUN ./install_pipeless.sh 

RUN pip install numpy ultralytics opencv-python pillow

## ==========================

# This section is for install others module if need.

# RUN pip install 

## =========================

ENV HOME=/root
ENV PATH="${PATH}:${HOME}/.pipeless"
ENV LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${HOME}/.pipeless"
USER root
WORKDIR /app
