# syntax = docker/dockerfile:1.0-experimental

FROM guangie88/muslrust-extra:stable AS build

RUN apt update -y && \
  apt install -y libmysqlclient-dev

RUN rustup target add x86_64-unknown-linux-musl
RUN --mount=target=/root/.cargo/registry/,rw \
  cargo install diesel_cli --no-default-features --features mysql --target x86_64-unknown-linux-musl

FROM alpine:3.13.3

WORKDIR /usr/src
COPY --from=build /root/.cargo/bin/diesel /usr/src/diesel

ENTRYPOINT [ "/usr/src/diesel" ]
