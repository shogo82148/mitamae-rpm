FROM rockylinux:9
RUN dnf update -y
RUN dnf install -y autoconf automake libtool
RUN dnf install -y wget git patch xz ruby
RUN dnf install -y rpm-build redhat-rpm-config rpmdevtools

# Install Zig
ENV ZIG_VERSION 0.9.1
RUN cd /tmp \
    && curl -sSL -O "https://ziglang.org/download/$ZIG_VERSION/zig-linux-$(uname -m)-$ZIG_VERSION.tar.xz" \
    && tar xf "zig-linux-$(uname -m)-$ZIG_VERSION.tar.xz" \
    && mv "zig-linux-$(uname -m)-$ZIG_VERSION" /usr/local/zig
ENV PATH /usr/local/zig:$PATH

# ARG VERSION
# ARG PLATFORM

ENV MITAMAE_VERSION 1.14.0

WORKDIR /root
RUN rpmdev-setuptree
COPY ./rpmbuild/ rpmbuild/
RUN cd rpmbuild/SOURCES/ \
    && curl -sSL -O "https://github.com/itamae-kitchen/mitamae/archive/refs/tags/v${MITAMAE_VERSION}.tar.gz"
RUN rpmbuild -ba --target $(uname -m) rpmbuild/SPECS/mitamae.spec

# RUN tar -czf /tmp/mitamae.tar.gz -C /rpmbuild RPMS SRPMS
# CMD ["/bin/true"]
