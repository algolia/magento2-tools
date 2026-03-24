#!/bin/bash
# Detects whether an extension directory resides within a Magento installation.
#
# Usage: source this file, then call detect_magento_root "$EXTENSION_DIR"
#
# Sets:
#   MAGENTO_ROOT — absolute path to the Magento root, or empty if not found

detect_magento_root() {
    local ext_dir="$1"

    # If the extension lives inside a vendor/ tree, the Magento root is
    # the directory that contains that vendor/ folder.
    if [[ "$ext_dir" == *"/vendor/"* ]]; then
        local candidate="${ext_dir%%/vendor/*}"
        if [ -f "$candidate/app/etc/env.php" ] || [ -f "$candidate/bin/magento" ]; then
            MAGENTO_ROOT="$candidate"
            return 0
        fi
    fi

    # Walk up the directory tree (max 5 levels) looking for Magento markers.
    local dir="$ext_dir"
    for _ in {1..5}; do
        dir="$(dirname "$dir")"
        if [ -f "$dir/app/etc/env.php" ] || [ -f "$dir/bin/magento" ]; then
            MAGENTO_ROOT="$dir"
            return 0
        fi
    done

    MAGENTO_ROOT=""
    return 1
}
