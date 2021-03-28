FROM rust:1.49-alpine AS build

RUN apk add --update --no-cache musl-dev mariadb-dev

RUN cargo install diesel_cli --no-default-features --features mysql

FROM alpine:3.13.3

COPY --from=build /usr/local/cargo/bin/diesel /bin/diesel

ENTRYPOINT [ "diesel" ]
