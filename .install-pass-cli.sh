#!/bin/sh

type pass-cli >/dev/null 2>&1 && exit
[ -x "$HOME/.local/bin/pass-cli" ] && exit

case "$(uname -s)" in
Linux) OS=linux ;;
Darwin) OS=macos ;;
*) echo "pass-cli: unsupported OS $(uname -s)" >&2 && exit 1 ;;
esac

case "$(uname -m)" in
x86_64 | amd64) ARCH=x86_64 ;;
arm64 | aarch64) ARCH=aarch64 ;;
*) echo "pass-cli: unsupported architecture $(uname -m)" >&2 && exit 1 ;;
esac

# macOS has no sha256sum
if type sha256sum >/dev/null 2>&1; then
  SHA256SUM="sha256sum"
else
  SHA256SUM="shasum -a 256"
fi

VERSIONS=$(curl -fsSL https://proton.me/download/pass-cli/versions.json)
VERSION=$(echo "$VERSIONS" | jq -r '.passCliVersions.version')
URL=$(echo "$VERSIONS" | jq -r ".passCliVersions.urls.$OS.$ARCH.url")
SHA256=$(echo "$VERSIONS" | jq -r ".passCliVersions.urls.$OS.$ARCH.hash")

curl -fsSL "$URL" -o /tmp/pass-cli
echo "$SHA256  /tmp/pass-cli" | $SHA256SUM --check - || exit 1

chmod +x /tmp/pass-cli
mkdir -p ~/.local/bin
mv /tmp/pass-cli ~/.local/bin/pass-cli
