FROM rockylinux/rockylinux:9
RUN dnf update -y
RUN dnf install -y autoconf automake libtool
RUN dnf install -y wget git patch xz ruby
# mitamae v2.0.0+ strips the release binary with llvm-strip (see the Rakefile).
RUN dnf install -y llvm
RUN dnf install -y rpm-build redhat-rpm-config rpmdevtools

# Install Zig
ENV ZIG_VERSION=0.16.0
RUN cd /tmp \
    && curl -sSL -O "https://ziglang.org/download/$ZIG_VERSION/zig-$(uname -m)-linux-$ZIG_VERSION.tar.xz" \
    && tar xf "zig-$(uname -m)-linux-$ZIG_VERSION.tar.xz" \
    && mv "zig-$(uname -m)-linux-$ZIG_VERSION" /usr/local/zig
ENV PATH=/usr/local/zig:$PATH

ARG VERSION
ARG PLATFORM

WORKDIR /root
RUN rpmdev-setuptree
COPY ./rpmbuild/ rpmbuild/

# use gzip instead of ztsd.
# some old distro does not support zstd.
# ref. https://www.reddit.com/r/openSUSE/comments/qhrzua/rpmbuild_takes_ages_different_algorithm/
# ref. https://github.com/shogo82148/mitamae-rpm/issues/25
RUN echo "%_source_payload w9.gzdio" >> ~/.rpmmacros
RUN echo "%_binary_payload w9.gzdio" >> ~/.rpmmacros

RUN cd rpmbuild/SOURCES/ \
    && curl -sSL -O "https://github.com/itamae-kitchen/mitamae/archive/refs/tags/v${VERSION}.tar.gz"
RUN rpmbuild -ba --target "${PLATFORM}" rpmbuild/SPECS/mitamae.spec

RUN tar -czvf /tmp/mitamae.tar.gz -C rpmbuild RPMS SRPMS
CMD ["/bin/true"]
