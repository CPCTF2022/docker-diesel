FROM rust:1.49-alpine AS build

RUN apk add --update --no-cache musl-dev mariadb-dev

RUN cargo install diesel_cli --no-default-features --features mysql

FROM alpine:3.13.3


WORKDIR /usr/src
COPY --from=build /usr/local/cargo/bin/diesel /usr/src/diesel

ENTRYPOINT [ "/usr/src/diesel" ]
