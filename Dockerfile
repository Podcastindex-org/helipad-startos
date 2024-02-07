# sha256 from: docker buildx imagetools inspect <image>
FROM podcastindexorg/podcasting20-helipad:0.1.11@sha256:b1292d46b4e126ad5c6c20c5630f28d9220ef4c8d90566d17be2232e238b9d4f

ARG ARCH
ARG PLATFORM

USER root

RUN apt-get update && \
    apt-get install -y tini yq && \
    rm -fr /var/lib/apt/lists/*

COPY ./docker_entrypoint.sh /usr/local/bin/docker_entrypoint.sh
RUN chmod +x /usr/local/bin/*.sh

ENTRYPOINT ["/usr/local/bin/docker_entrypoint.sh"]
