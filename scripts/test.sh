#!/bin/bash

set -exu

ARCH=$1
ROOT=$(cd "$(dirname "$0")/../" && pwd)

PLATFORM=unknown
if [[ "$ARCH" = "x86_64" ]]; then
    PLATFORM=linux/amd64
fi
if [[ "$ARCH" = "aarch64" ]]; then
    PLATFORM=linux/arm64
fi

docker run \
    --rm \
    -v "$ROOT/$ARCH.build:/build" \
    --platform "$PLATFORM" \
    amazonlinux:2022 \
    sh -c "yum update -y && yum install -y \"/build/RPMS/\$(uname -m)\"/*.rpm && mitamae help"

docker run \
    --rm \
    -v "$ROOT/$ARCH.build:/build" \
    --platform "$PLATFORM" \
    almalinux:9 \
    sh -c "yum update -y && yum install -y \"/build/RPMS/\$(uname -m)\"/*.rpm && mitamae help"

docker run \
    --rm \
    -v "$ROOT/$ARCH.build:/build" \
    --platform "$PLATFORM" \
    almalinux:9 \
    sh -c "yum update -y && yum install -y \"/build/RPMS/\$(uname -m)\"/*.rpm && mitamae help"

docker run \
    --rm \
    -v "$ROOT/$ARCH.build:/build" \
    --platform "$PLATFORM" \
    rockylinux/rockylinux:8 \
    sh -c "yum update -y && yum install -y \"/build/RPMS/\$(uname -m)\"/*.rpm && mitamae help"

docker run \
    --rm \
    -v "$ROOT/$ARCH.build:/build" \
    --platform "$PLATFORM" \
    rockylinux/rockylinux:9 \
    sh -c "yum update -y && yum install -y \"/build/RPMS/\$(uname -m)\"/*.rpm && mitamae help"
