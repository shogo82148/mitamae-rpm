#!/bin/bash

set -exu

ROOT=$(cd "$(dirname "$0")/../" && pwd)
PLATFORM=$1
VERSION=v1.14.0

IMAGE_NAME=mitamae-package-$PLATFORM
TARGZ_FILE=mitamae.tar.gz

rm -rf "$PLATFORM.build.bak"
if [[ -d "$PLATFORM.build" ]];
then
    mv "$PLATFORM.build" "$PLATFORM.build.bak"
fi

docker build \
    --build-arg PLATFORM="$PLATFORM" \
    --build-arg VERSION="$VERSION" \
    -t "$IMAGE_NAME" "$ROOT"

docker run --name "$IMAGE_NAME-tmp" "$IMAGE_NAME"
mkdir -p "$ROOT/tmp"
docker wait "$IMAGE_NAME-tmp"
docker cp "$IMAGE_NAME-tmp:/tmp/$TARGZ_FILE" "$ROOT/tmp"
docker rm "$IMAGE_NAME-tmp"

mkdir -p "$PLATFORM.build"
tar -xzf "$ROOT/tmp/$TARGZ_FILE" -C "$PLATFORM.build"
rm -rf "$ROOT/tmp"
