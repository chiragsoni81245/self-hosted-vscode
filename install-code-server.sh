#!/bin/bash

# Parse arguments
while [[ "$#" -gt 0 ]]; do
  case "$1" in
    --base-path)
      BASE_PATH="$2"
      shift 2
      ;;
    --version)
      CODE_SERVER_VERSION="$2"
      shift 2
      ;;
    *)
      echo "Unknown parameter passed: $1"
      exit 1
      ;;
  esac
done

# Ensure CODE_SERVER_VERSION is set
if [ -z "$BASE_PATH" ]; then
  echo "Error:  --base-path argument not passed."
  exit 1
fi

# Ensure CODE_SERVER_VERSION is set
if [ -z "$CODE_SERVER_VERSION" ]; then
  echo "Error: CODE_SERVER_VERSION variable not set."
  exit 1
fi

# Create directories
mkdir -p "$BASE_PATH/lib" "$BASE_PATH/bin"

# Download and extract code-server
curl -fL "https://github.com/coder/code-server/releases/download/v$CODE_SERVER_VERSION/code-server-$CODE_SERVER_VERSION-linux-amd64.tar.gz" \
  | tar -C "$BASE_PATH/lib" -xz

# Rename and link
mv "$BASE_PATH/lib/code-server-$CODE_SERVER_VERSION-linux-amd64" "$BASE_PATH/lib/code-server-$CODE_SERVER_VERSION"
ln -s "$BASE_PATH/lib/code-server-$CODE_SERVER_VERSION/bin/code-server" "/bin/code-server"
