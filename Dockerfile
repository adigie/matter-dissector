FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive
ARG ENV TZ=Europe/Warsaw

RUN apt-get update && apt-get install -y --no-install-recommends \
  ca-certificates \
  git make cmake gcc g++ python3 \
  libglib2.0-dev libgcrypt20-dev libc-ares-dev flex \
  qt6-base-dev qt6-tools-dev qt6-5compat-dev \
  libspeexdsp-dev libssl-dev && \
  rm -rf /var/lib/apt/lists/*

RUN git clone --depth=1 https://gitlab.com/wireshark/wireshark.git --branch v4.4.1
RUN cd ./wireshark && cmake -B build -S .

COPY . ./matter-dissector
RUN cd ./matter-dissector && make

CMD mkdir -p /out && cp ./matter-dissector/matter-dissector.so /out
