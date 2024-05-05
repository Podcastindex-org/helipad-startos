# sha256 from: docker buildx imagetools inspect <image>
FROM podcastindexorg/podcasting20-helipad:0.2.0@sha256:1e298d6986840ae5304c53ccdd3770cde867e6cab6837997e1c45f89538a0568

ARG ARCH
ARG PLATFORM

USER root

RUN apt-get update && \
    apt-get install -y tini yq && \
    rm -fr /var/lib/apt/lists/*

COPY ./docker_entrypoint.sh /usr/local/bin/docker_entrypoint.sh
RUN chmod +x /usr/local/bin/*.sh

ENTRYPOINT ["/usr/local/bin/docker_entrypoint.sh"]
