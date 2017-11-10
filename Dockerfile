FROM alpine:latest

# on-imagebuilder docker build just package the static files into an image.
# So before docker build the static files must have been built and stored
# in on-imagebuilder directory. Default folders are common and pxe.
# You can use your own folders with
#     docker build --build-arg common=<mysrc> ...
# Following Dockerfile rules, the <mysrc> path must be inside the context of the build.

ARG common_files=./common/*
ARG pxe_files=./pxe/*
RUN mkdir -p /RackHD/downloads
COPY ${pxe_files} /RackHD/downloads/

RUN mkdir -p /RackHD/downloads/common
COPY ${common_files} /RackHD/downloads/common/

VOLUME /RackHD/files

COPY ./docker-entrypoint.sh /docker-entrypoint.sh

CMD [ "/docker-entrypoint.sh" ]

