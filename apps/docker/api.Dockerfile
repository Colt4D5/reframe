# ------------------------------------------------------------------------------
# Build
# ------------------------------------------------------------------------------

FROM golang:1.25-alpine AS build

WORKDIR /app

# Download dependencies first so Docker can cache this layer.
COPY apps/backend/go.mod ./

RUN go mod download

# Copy source
COPY apps/backend ./

# Build a static binary.
RUN CGO_ENABLED=0 GOOS=linux go build \
    -ldflags="-s -w" \
    -o /bin/server \
    ./cmd/server


# ------------------------------------------------------------------------------
# Production
# ------------------------------------------------------------------------------

FROM alpine:3.22 AS production

RUN apk add --no-cache ca-certificates

WORKDIR /app

COPY --from=build /bin/server ./server

EXPOSE 8080

USER 65532:65532

ENTRYPOINT ["./server"]