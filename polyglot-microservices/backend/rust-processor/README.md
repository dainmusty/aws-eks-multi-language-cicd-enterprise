# Rust Processor Microservice

A high-performance Rust microservice using Actix-web framework for RESTful API endpoints.

## Features

- Actix-web framework
- Async/await support with Tokio
- Type-safe RESTful API
- JSON serialization with Serde
- Comprehensive logging
- Multi-stage Docker build
- Health check endpoint
- Minimal binary size

## Getting Started

### Prerequisites

- Rust 1.75+
- Cargo

### Build

```bash
cargo build --release
```

### Run

```bash
cargo run --release
```

### Testing

```bash
cargo test
```

### Docker Build

```bash
docker build -t dainmusty/rust-processor:stable .
docker push dainmusty/rust-processor:dev-latest2
docker run -p 8888:8888 rust-processor:1.0.0
```

## API Endpoints

- `GET /health` - Health check
- `GET /api/items` - Get all items
- `POST /api/items` - Create item
- `GET /api/items/:id` - Get item by ID
- `PUT /api/items/:id` - Update item
- `DELETE /api/items/:id` - Delete item

## Environment Variables

- `PORT` - Server port (default: 8888)
- `RUST_LOG` - Log level (default: info)

## Performance

Built with Rust for maximum performance and memory safety:
- Zero-cost abstractions
- Memory safe without garbage collection
- Excellent startup time
- Minimal resource usage




# Rust Best Practices
Optimized dockerfile
# cargo-chef for dependency caching
FROM rust:1.75 AS chef
RUN cargo install cargo-chef
WORKDIR /app

# Compute recipe file
FROM chef AS planner
COPY . .
RUN cargo chef prepare --recipe-path recipe.json

# Build dependencies (cached layer)
FROM chef AS builder
COPY --from=planner /app/recipe.json recipe.json
RUN cargo chef cook --release --recipe-path recipe.json

# Build application
COPY . .
RUN cargo build --release

# Production image
FROM debian:bookworm-slim

WORKDIR /app

# Copy binary
COPY --from=builder /app/target/release/rust-processor .

# Security
USER nobody

CMD ["./rust-processor"]

