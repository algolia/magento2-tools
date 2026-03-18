#!/bin/bash
# Common environment setup for magento2-tools scripts.
# Expects DIR and VENDOR_BIN to be set by the caller before sourcing.

LIB_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
BIN_DIR="$LIB_DIR/../bin"

MAGENTO_PATH="$(cd "$DIR/../../.." && pwd)"
EXTENSION_PATH="$MAGENTO_PATH/vendor/algolia/algoliasearch-magento-2"

if [ -z "$VENDOR_BIN" ]; then
  if [ -d "$LIB_DIR/../vendor/bin" ]; then
    VENDOR_BIN="$LIB_DIR/../vendor/bin/"
  elif [ -d "$LIB_DIR/../../../bin" ]; then
    VENDOR_BIN="$LIB_DIR/../../../bin/"
  fi
fi

"$BIN_DIR/magento2-update"
