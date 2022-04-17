# base builder
FROM rust:1.60.0 as chef

WORKDIR /app
RUN apt-get update && apt-get install lld clang -y
RUN cargo install cargo-chef
RUN rustup component add rustfmt clippy

# rust layer caching
FROM chef as planner
COPY . .
RUN cargo chef prepare --recipe-path recipe.json

# rebuild if dependencies changed
FROM chef as builder
COPY --from=planner /app/recipe.json recipe.json
RUN cargo chef cook --release --recipe-path recipe.json
COPY . .
# Excessive cargo checks because I can
RUN cargo check
RUN cargo fmt --check
RUN cargo clippy
RUN cargo build --release
RUN cargo test --all --release

# light runtime
FROM debian:bullseye-slim AS runtime
WORKDIR /app
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends openssl ca-certificates \
    # Clean up so runtime is light
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*
COPY --from=builder /app/target/release/zero2prod zero2prod

ENTRYPOINT ["./zero2prod"]
