FROM golang:1.24.4-alpine AS builder

WORKDIR /src
COPY . .

RUN apk add --no-cache git && \
    go mod download && \
    CGO_ENABLED=0 go build -ldflags="-s -w" -buildvcs=false -o "SignTools"

FROM alpine:3.21.3

WORKDIR /

COPY --from=builder "/src/SignTools" "/"

# Environment variables for configuration paths
# SIGNER_CONFIG_PATH: Path to the signer-cfg.yml configuration file (optional)
# SAVE_DIR_PATH: Path to the directory where signed apps will be saved (optional)
# If not set, the application will use default paths

ENTRYPOINT ["/SignTools"]
EXPOSE 8080
