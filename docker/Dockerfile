FROM ubuntu:23.04

ARG VCPKG_VERSION

# update system & install required dev packages
RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    cmake \
    make \
    libjsoncpp-dev \
    uuid-dev \
    openssl \
    libssl-dev \
    zlib1g-dev \
    openssh-server \
    net-tools \
    vim \
    less \
    rsync \
    gdb \
    flex \
    bison \
    python3-sphinx \
    python3-sphinx-rtd-theme \
    python3-sphinx-sitemap \
    python3-breathe \
    nginx \
    htop \
    bat \
    zip curl git g++ build-essential pkg-config \
    libmariadb-dev-compat=1:10.11.2-1 \
    libmariadb-dev=1:10.11.2-1 \
    mariadb-server=1:10.11.2-1 \
    && rm -rf /var/lib/apt/lists/*

RUN curl https://github.com/google/googletest/archive/release-1.12.1.tar.gz > /dev/null
#
## install vcpkg
#RUN git clone https://github.com/Microsoft/vcpkg.git --branch ${VCPKG_VERSION} --single-branch /opt/vcpkg
#WORKDIR /opt/vcpkg
#RUN ./bootstrap-vcpkg.sh && ./vcpkg integrate install && ./vcpkg integrate bash && echo 'export PATH=$PATH:/opt/vcpkg' >>~/.bashrc
#COPY vcpkg.json /vcpkg.json
#RUN ./vcpkg x-update-baseline --add-initial-baseline
#RUN ./vcpkg install --feature-flags=manifests
#
## json cpp
#RUN ln -s /usr/include/jsoncpp/json/ /usr/include/json
#
## setup ssh
#RUN mkdir -p /var/run/sshd
#RUN echo 'root:12345' | chpasswd
#RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
#
## SSH login fix. Otherwise user is kicked off after login
#RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
