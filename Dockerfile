# syntax = docker/dockerfile:1.0-experimental

FROM rust:1.51.0-slim AS build

RUN apt update -y && \
  apt install -y default-libmysqlclient-dev

RUN cargo install diesel_cli --no-default-features --features mysql

FROM debian:bullseye-slim

WORKDIR /usr/src

RUN apt update -y && \
  apt install -y default-libmysqlclient-dev
COPY --from=build /usr/local/cargo/bin/diesel ./

ENTRYPOINT [ "/usr/src/diesel" ]
