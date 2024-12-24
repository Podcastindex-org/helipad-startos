# sha256 from: docker buildx imagetools inspect <image>
FROM podcastindexorg/podcasting20-helipad:0.2.1@sha256:97caa32c6f5c7662d37bf6b0d48a0b54b384af3f2794e53b9129ededfe71dfc2

ARG ARCH
ARG PLATFORM

USER root

RUN apt-get update && \
    apt-get install -y tini yq && \
    rm -fr /var/lib/apt/lists/*

COPY ./docker_entrypoint.sh /usr/local/bin/docker_entrypoint.sh
RUN chmod +x /usr/local/bin/*.sh

ENTRYPOINT ["/usr/local/bin/docker_entrypoint.sh"]
