FROM ubuntu:24.04

# Install necessary tools
RUN apt-get update && apt-get install -y \
    curl \
    tar \
 && rm -rf /var/lib/apt/lists/*

# Get serial-test binary
ENV SERIALTEST_VERSION=v1.2.0
ENV BASE_URL=https://github.com/ci4rail/linux-serial-test/releases/download/${SERIALTEST_VERSION}

RUN ARCH=$(dpkg --print-architecture) && \
    echo "Detected architecture: $ARCH" && \
    case "$ARCH" in \
      amd64)  FILE=linux-serial-test-${SERIALTEST_VERSION}-linux-amd64.tar.gz ;; \
      arm64)  FILE=linux-serial-test-${SERIALTEST_VERSION}-linux-arm64.tar.gz ;; \
      armhf)  FILE=linux-serial-test-${SERIALTEST_VERSION}-linux-armv7.tar.gz ;; \
      *) echo "Unsupported architecture: $ARCH" && exit 1 ;; \
    esac && \
    curl -LO "${BASE_URL}/${FILE}" && \
    tar -xzf "$FILE" && \
    mv linux-serial-test /usr/local/bin/linux-serial-test && \
    chmod +x /usr/local/bin/linux-serial-test && \
    rm "$FILE"

# Get gpsdtestclient binary
#ENV GPSDTESTCLIENT_VERSION=v1.0.0
