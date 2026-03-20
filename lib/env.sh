#!/bin/bash
# Common environment setup for magento2-tools scripts.
# Expects EXTENSION_DIR and VENDOR_BIN to be set by the caller before sourcing.

LIB_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
BIN_DIR="$LIB_DIR/../bin"

# Resolve the vendor bin directory if not explicitly provided as argument 2.
#
# Two install layouts are supported:
#
#   1. Local (composer install inside this repo):
#      lib/../vendor/bin/ → magento2-tools/vendor/bin/
#      Used when developing or testing the package locally before publishing.
#
#   2. Global (composer global require algolia/magento2-tools):
#      lib/../../../bin/ → ~/.composer/vendor/bin/
#      Used in the normal installed state; all Composer bin scripts are
#      symlinked into the global vendor bin directory three levels above lib/.
#
# If neither directory exists, VENDOR_BIN remains empty and the tools are
# expected to be available on $PATH.
if [ -z "$VENDOR_BIN" ]; then
  # Local
  if [ -d "$LIB_DIR/../vendor/bin" ]; then
    VENDOR_BIN="$LIB_DIR/../vendor/bin/"
  # Global
  elif [ -d "$LIB_DIR/../../../bin" ]; then
    VENDOR_BIN="$LIB_DIR/../../../bin/"
  fi
fi

# Guard against running the update check twice when scripts delegate to each other
# (e.g. magento2-test calling magento2-analyse).
if [ -z "$MAGENTO2_TOOLS_ENV_LOADED" ]; then
    "$BIN_DIR/magento2-update"
    export MAGENTO2_TOOLS_ENV_LOADED=1
fi
