FROM ubuntu:latest AS builder

WORKDIR /root
RUN mkdir -p /root/code /root/code-server

# Install base packages
RUN apt update && \
    apt install -y git curl gcc g++

ENV CODE_SERVER_VERSION="4.101.2"
COPY ./install-code-server.sh /root/code-server
RUN /bin/bash /root/code-server/install-code-server.sh --base-path /root/code-server --version $CODE_SERVER_VERSION && \
    rm /root/code-server/install-code-server.sh

EXPOSE 8080
CMD ["/bin/code-server", "--auth", "password", "--bind-addr", "0.0.0.0:8080", "--disable-telemetry"]
