#!/bin/sh
set -e

source_path="${1:?missing first argument: tar archive of cargo project}"
dest_path="${2:?missing second argument: path of output executable}"

rm -rf __proj
mkdir __proj
tar --strip-components=1 -xf "$source_path" -C __proj
cd __proj
cargo --offline build --release # --target x86_64-unknown-linux-musl

target_dir="$(cargo metadata --format-version 1 --no-deps | jq -r '.target_directory')"
bin_name="$(cargo metadata --format-version 1 --no-deps | jq -r '.packages[].targets[] | select( .kind | map(. == "bin") | any ) | .name')"
binary_path="$target_dir/release/$bin_name"

cd ..
cp "$binary_path" "$dest_path"
rm -rf __proj
