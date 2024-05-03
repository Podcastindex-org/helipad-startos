# sha256 from: docker buildx imagetools inspect <image>
FROM podcastindexorg/podcasting20-helipad@sha256:1872f331d674b24bfb419a8229a5701912398ef3649d212dc5641780393f1ae2

ARG ARCH
ARG PLATFORM

USER root

RUN apt-get update && \
    apt-get install -y tini yq && \
    rm -fr /var/lib/apt/lists/*

COPY ./docker_entrypoint.sh /usr/local/bin/docker_entrypoint.sh
RUN chmod +x /usr/local/bin/*.sh

ENTRYPOINT ["/usr/local/bin/docker_entrypoint.sh"]
