#!/bin/sh

type pass-cli >/dev/null 2>&1 && exit

VERSIONS=$(curl -fsSL https://proton.me/download/pass-cli/versions.json)
VERSION=$(echo "$VERSIONS" | jq -r '.passCliVersions.version')
URL=$(echo "$VERSIONS" | jq -r '.passCliVersions.urls.linux.x86_64.url')
SHA256=$(echo "$VERSIONS" | jq -r '.passCliVersions.urls.linux.x86_64.hash')

curl -fsSL "$URL" -o /tmp/pass-cli
echo "$SHA256  /tmp/pass-cli" | sha256sum --check - || exit 1

chmod +x /tmp/pass-cli
mkdir -p ~/.local/bin
mv /tmp/pass-cli ~/.local/bin/pass-cli
