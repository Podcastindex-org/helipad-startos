# sha256 from: docker buildx imagetools inspect <image>
FROM podcastindexorg/podcasting20-helipad:0.2.2@sha256:bd300d26dd605dd73bb2c942db67903bbe24f0b63035aa3cd64727df181d4cc5

ARG ARCH
ARG PLATFORM

USER root

RUN apt-get update && \
    apt-get install -y tini yq && \
    rm -fr /var/lib/apt/lists/*

COPY ./docker_entrypoint.sh /usr/local/bin/docker_entrypoint.sh
RUN chmod +x /usr/local/bin/*.sh

ENTRYPOINT ["/usr/local/bin/docker_entrypoint.sh"]
