# Use Ubuntu as the base image
FROM riscv64/ubuntu:22.04

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends wget tar gzip ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*



# Set environment variables
ENV PROMETHEUS_VERSION=3.2.1

# Create directories for Prometheus
RUN mkdir -p /etc/prometheus var/lib/prometheus

# Download and extract Prometheus
RUN wget https://github.com/prometheus/prometheus/releases/download/v${PROMETHEUS_VERSION}/prometheus-${PROMETHEUS_VERSION}.linux-riscv64.tar.gz \
    && tar -xzf prometheus-${PROMETHEUS_VERSION}.linux-riscv64.tar.gz \
    && mv prometheus-${PROMETHEUS_VERSION}.linux-riscv64/prometheus /usr/local/bin/ \
    && mv prometheus-${PROMETHEUS_VERSION}.linux-riscv64/promtool /usr/local/bin/ \	
    && rm -rf prometheus-${PROMETHEUS_VERSION}.linux-riscv64.tar.gz prometheus-${PROMETHEUS_VERSION}.linux-riscv64

# Copy custom configuration file (optional)
COPY prometheus.yml /etc/prometheus/prometheus.yml

RUN useradd -rs /bin/false prometheus && chown -R prometheus:prometheus /etc/prometheus 

# Expose port 9090 for Prometheus
EXPOSE 9090

# Set entrypoint to run Prometheus
ENTRYPOINT ["/usr/local/bin/prometheus"]
CMD ["--config.file=/etc/prometheus/prometheus.yml"]
