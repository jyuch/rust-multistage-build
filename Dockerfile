FROM rust:1.65.0-bullseye AS builder

ADD . /src
WORKDIR /src
RUN --mount=type=cache,target=/usr/local/cargo/registry \
    cargo build --release

FROM gcr.io/distroless/cc

COPY --from=builder /src/target/release/ferris_says ferris_says
CMD ["./ferris_says"]
