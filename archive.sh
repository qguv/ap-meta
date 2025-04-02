#!/bin/sh

set -e

dir="${1:?root directory of cargo project}"

env="env"
if [ "$(uname)" = "Darwin" ]; then
    env="genv"
fi

$env -C "$dir" cargo vendor
exec tar --exclude-vcs --exclude="./prob-*.pdf" --exclude="./target" --exclude="./samples-*" --exclude="./*.DS_Store" --exclude="./.vscode" -cavf "$dir.tar.xz" "$dir"
