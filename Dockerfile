FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive
ARG ENV TZ=Europe/Warsaw

RUN apt-get update && apt-get install -y --no-install-recommends \
  ca-certificates \
  build-essential git cmake flex bison qttools5-dev qttools5-dev-tools libqt5svg5-dev qtmultimedia5-dev libpcap-dev libc-ares-dev libgcrypt20-dev libglib2.0-dev libpcre2-dev libnghttp2-dev libqt5core5a \
  libssl-dev && \
  rm -rf /var/lib/apt/lists/*

RUN git clone --depth=1 https://gitlab.com/wireshark/wireshark.git --branch release-3.6
RUN cd ./wireshark && cmake -B build -S .

COPY . ./matter-dissector
RUN cd ./matter-dissector && make

CMD mkdir -p /out && cp ./matter-dissector/matter-dissector.so /out
