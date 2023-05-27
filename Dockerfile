##: Build stage
FROM rust:latest AS builder

# arm64 or amd64
ARG PLATFORM

USER root

RUN apt-get update
RUN apt-get install -y apt-utils sqlite3 openssl

COPY helipad /opt/helipad

WORKDIR /opt/helipad
RUN cargo build --release
RUN cp target/release/helipad .

##: Bundle stage
FROM debian:buster-slim AS runner

ARG ARCH
ARG PLATFORM

USER root

RUN apt-get update && apt-get install -y apt-utils ca-certificates openssl sqlite3 tini

COPY ./docker_entrypoint.sh /usr/local/bin/docker_entrypoint.sh
COPY ./check-web.sh /usr/local/bin/check-web.sh
RUN chmod +x /usr/local/bin/*.sh

RUN mkdir /opt/helipad

WORKDIR /opt/helipad
COPY --from=builder /opt/helipad/target/release/helipad .
COPY --from=builder /opt/helipad/webroot ./webroot
COPY --from=builder /opt/helipad/helipad.conf .

RUN useradd -u 1000 helipad

EXPOSE 2112/tcp

ENTRYPOINT ["/usr/local/bin/docker_entrypoint.sh"]
