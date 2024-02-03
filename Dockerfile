# sha256 from: docker buildx imagetools inspect <image>
FROM ericpp/helipad@sha256:7d37cdc143a00e262fab75e87d4de1eb4e1f56e16f6d03026bae165bf33d4fb9

ARG ARCH
ARG PLATFORM

USER root

RUN apt-get update && \
    apt-get install -y tini yq && \
    rm -fr /var/lib/apt/lists/*

COPY ./docker_entrypoint.sh /usr/local/bin/docker_entrypoint.sh
RUN chmod +x /usr/local/bin/*.sh

ENTRYPOINT ["/usr/local/bin/docker_entrypoint.sh"]
