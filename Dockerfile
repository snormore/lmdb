FROM ubuntu
 
MAINTAINER SkyDB skydb.io

RUN echo 'deb http://archive.ubuntu.com/ubuntu precise main universe' > /etc/apt/sources.list && \
    echo 'deb http://archive.ubuntu.com/ubuntu precise-updates universe' >> /etc/apt/sources.list && \
    apt-get update

#Prevent daemon start during install
RUN dpkg-divert --local --rename --add /sbin/initctl && ln -s /bin/true /sbin/initctl

#Utilities
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential vim less curl git wget

RUN mkdir -p /usr/local/src

RUN cd /usr/local/src && \
    wget -O lmdb-master.tar.gz https://github.com/skydb/lmdb/archive/master.tar.gz && \
    tar zxvf lmdb-master.tar.gz && \
    cd lmdb-master && \
    make && \
    PREFIX=/usr/local make install

