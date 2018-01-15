FROM debian:jessie

RUN apt-get update && apt-get install --no-install-recommends -y \
               ipmitool \
               python \
               curl \
               vim-tiny \
               less \
               ca-certificates \
               sudo \
               ifupdown \
               udev \
    && rm -rf /var/lib/apt/lists/*

ENV NODE_VERSION 4.6.2
RUN curl -SLO "http://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" \
    && tar -xzf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1 \
    && rm "node-v$NODE_VERSION-linux-x64.tar.gz"

RUN mkdir -p /opt/ami \
    && mkdir -p /opt/socflash

ADD ami /opt/ami
ADD socflash /opt/socflash

RUN chmod 755 /opt/ami/* \
    && chmod 755 /opt/socflash/*

ADD entry.bash /usr/local/bin/
CMD /usr/local/bin/entry.bash
