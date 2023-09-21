# sha256 from: docker buildx imagetools inspect <image>
FROM ericpp/helipad@sha256:bab8e68b8fc7f8175c9d5c3bb72367013720bded70dcc20d81af441272ec73c0

ARG ARCH
ARG PLATFORM

USER root

RUN apt-get update && \
    apt-get install -y tini && \
    rm -fr /var/lib/apt/lists/*

COPY ./docker_entrypoint.sh /usr/local/bin/docker_entrypoint.sh
RUN chmod +x /usr/local/bin/*.sh

ENTRYPOINT ["/usr/local/bin/docker_entrypoint.sh"]
