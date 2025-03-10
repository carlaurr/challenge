#!/bin/bash
APP_NAME="app"
APP_PATH="$PWD/app"
BIN_PATH="$PWD/bin"

cd "$APP_PATH" || exit 1
for ARCH in amd64 arm64; do
    echo "Compiling ${APP_NAME}-${ARCH}"

    bin_name="${APP_NAME}-${ARCH}"

    CGO_ENABLED=0 GOOS="${GOOS:-linux}" GOARCH="${ARCH}" go build -tags netgo \
      -o "$BIN_PATH/$bin_name" "$APP_PATH"
    echo "Done with ${APP_NAME}-${ARCH}"
done
