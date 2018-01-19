FROM debian:jessie

RUN apt-get update && apt-get install --no-install-recommends -y \
               vim-tiny \
               less \
               python \
               ca-certificates \
               sudo \
               git \
               binutils-dev \
               mktemp \
               mtools \
               nasm \
               perl \
               mingw32-binutils \
               mingw-w64 \
               e2fslibs-dev \
               build-essential \
    && rm -rf /var/lib/apt/lists/*

ENV GITTAG syslinux-4.04

RUN git clone https://git.kernel.org/pub/scm/boot/syslinux/syslinux.git \
    && cd syslinux \
    && git checkout $GITTAG

WORKDIR syslinux

ENV BUILD_ARTIFACT_PATH /build-syslinux-artifact-path
RUN mkdir $BUILD_ARTIFACT_PATH

ENV PATCH 0001-Fix-compiling-failure-on-Ubuntu-14.04.patch
ADD $PATCH .

RUN git apply $PATCH \
    && make clean \
    && make \
    && cp gpxe/src/bin/undionly.kkpxe $BUILD_ARTIFACT_PATH

CMD tail -f /dev/null
