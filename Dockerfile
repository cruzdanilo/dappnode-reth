ARG UPSTREAM_VERSION
FROM ghcr.io/paradigmxyz/reth:v${UPSTREAM_VERSION}

# hadolint ignore=DL3008
RUN apt-get update && apt-get install curl --yes --no-install-recommends && \
  rm -rf /var/lib/apt/lists/*

COPY /security /security
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
