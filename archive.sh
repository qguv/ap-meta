#!/bin/sh

set -e

dir="${1:?root directory of cargo project}"

env="env"
tar="tar"
if [ "$(uname)" = "Darwin" ]; then
    env="genv"
    tar="tar --no-xattrs"
fi


$env -C "$dir" cargo vendor
exec $tar --exclude-vcs --exclude="./prob-*.pdf" --exclude="./target" --exclude="./samples-*" --exclude="./*.DS_Store" --exclude="./.vscode" -cavf "$dir.tar.xz" "$dir"
