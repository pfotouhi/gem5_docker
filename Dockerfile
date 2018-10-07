FROM ubuntu:16.04

RUN apt-get update && apt-get install -y \
    build-essential \
    gcc-multilib \
    g++-multilib \
    git \
    m4 \
    scons \
    zlib1g \
    zlib1g-dev \
    libprotobuf-dev \
    protobuf-compiler \
    libprotoc-dev \
    libgoogle-perftools-dev \
    python-dev \
    python \
    python-yaml \
    wget \
    libpci3 \
    libelf1 \
    libelf-dev \
    vim \
    cmake \
    cmake-qt-gui \
    libboost-program-options-dev \
    gfortran \
    openssl \
    libssl-dev \
    libboost-filesystem-dev \
    libboost-system-dev

WORKDIR /sim

RUN wget -qO- repo.radeon.com/rocm/archive/apt_1.6.0.tar.bz2 \
    | tar -xjv \
    && cd apt_1.6.0/debian/pool/main/ \
    && dpkg -i h/hsakmt-roct-dev/* \
    && dpkg -i h/hsa-ext-rocr-dev/* \
    && dpkg -i h/hsa-rocr-dev/* \
    && dpkg -i r/rocm-utils/* \
    && dpkg -i h/hcc/* \
    && dpkg -i r/rocm-opencl/* \
    && dpkg -i r/rocm-opencl-dev/*

ENV ROCM_PATH /opt/rocm
ENV HCC_HOME ${ROCM_PATH}/hcc
ENV HSA_PATH ${ROCM_PATH}/hsa
ENV HIP_PLATFORM hcc
ENV PATH ${ROCM_PATH}/bin:${PATH}
#ENV LD_LIBRARY_PATH /usr/lib/x86_64-linux-gnu:${LD_LIBRARY_PATH}

CMD bash
