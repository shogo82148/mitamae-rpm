FROM centos:7
ENV HOME /
RUN yum update -y
RUN yum install -y rpm-build redhat-rpm-config rpmdevtools

ARG PLATFORM

RUN rpmdev-setuptree
ADD ./rpmbuild/ /rpmbuild/
RUN chown -R root:root /rpmbuild
RUN cd /rpmbuild/SOURCES/ && \
    curl -sSL -O "https://github.com/itamae-kitchen/mitamae/releases/download/v1.12.1/mitamae-$PLATFORM-linux.tar.gz"
RUN rpmbuild -ba --target "$PLATFORM" /rpmbuild/SPECS/mitamae.spec
RUN tar -czf /tmp/mitamae.tar.gz -C /rpmbuild RPMS SRPMS
CMD ["/bin/true"]
