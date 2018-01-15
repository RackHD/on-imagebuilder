FROM debian:jessie

RUN apt-get update && apt-get install --no-install-recommends -y \
               ipmitool \
               python \
               curl \
               vim-tiny \
               less \
               ca-certificates \
               sudo \
               dmidecode \
               ifupdown \
               git \
               liblzma-dev \
               libz-dev \
               syslinux \
               genisoimage \
               binutils-dev \
               build-essential \
               libiberty-dev \
               udev \
    && rm -rf /var/lib/apt/lists/*

ENV GITBRANCH fd6d1f4660a37d75acba1c64e2e5f137307bbc31

RUN git clone https://github.com/ipxe/ipxe.git \
    && cd ipxe \
    && git checkout $GITBRANCH

WORKDIR ipxe/src
ADD general.h config/local
ADD dhcp.h config/local
ADD default.ipxe .

ENV BUILD_ARTIFACT_PATH /build-ipxe-artifact-path
RUN mkdir $BUILD_ARTIFACT_PATH

######
# Group of ops to build our "general code", which is to say
#  the monorail.ipxe base image. The group build boths the
#  production monorail.ipxe, but also a couple of debug ones.
RUN make clean \
    && make EMBED=default.ipxe \
    && cp bin/ipxe.pxe $BUILD_ARTIFACT_PATH/monorail.ipxe \
    && cp bin/undionly.kpxe $BUILD_ARTIFACT_PATH/monorail-undionly.kpxe

# Build the Intel specific/only version of iPXE
RUN make bin/intel.pxe EMBED=default.ipxe \
    && cp bin/intel.pxe $BUILD_ARTIFACT_PATH/monorail.intel.ipxe

# Now for a version of the same to help debug communication issues.
RUN make DEBUG=dhcp:9,tftp,config:9,netdevice bin/ipxe.pxe EMBED=default.ipxe \
    && cp bin/ipxe.pxe $BUILD_ARTIFACT_PATH/monorail.ipxe.com_debug

# Now for a version of the same to help debug more device-type issues. Note, this is called
#  ".debug" to match existing use of .debug.
RUN make DEBUG=pci,device,intel bin/ipxe.pxe EMBED=default.ipxe \
    && cp bin/ipxe.pxe $BUILD_ARTIFACT_PATH/monorail.ipxe.debug

#####
# Group of ops for EFI builds targets
# disable COMBOOT in general.h for EFI builds
RUN sed -i '3 s/^/\/\//' config/local/general.h \
    && make bin-x86_64-efi/snponly.efi EMBED=default.ipxe \
    && make bin-i386-efi/snponly.efi \
    && cp bin-x86_64-efi/snponly.efi $BUILD_ARTIFACT_PATH/monorail-efi64-snponly.efi \
    && cp bin-i386-efi/snponly.efi $BUILD_ARTIFACT_PATH/monorail-efi32-snponly.efi

CMD tail -f /dev/null
