# sha256 from: docker buildx imagetools inspect <image>
FROM podcastindexorg/podcasting20-helipad@sha256:6767de3126b0a7d317f7c87766a1f063baa44fb85dc5496c794ff9aff306a4c1

ARG ARCH
ARG PLATFORM

USER root

RUN apt-get update && \
    apt-get install -y tini && \
    rm -fr /var/lib/apt/lists/*

COPY ./docker_entrypoint.sh /usr/local/bin/docker_entrypoint.sh
RUN chmod +x /usr/local/bin/*.sh

ENTRYPOINT ["/usr/local/bin/docker_entrypoint.sh"]
