#!/bin/bash
# Parse magento2-tools wrapper flags out of the caller's positional args.
#
# Recognised flags:
#   --json    Switch the script into machine-readable JSON output mode.
#             Wrapper banners and progress messages get routed to stderr,
#             and the underlying tool is invoked with its native JSON
#             formatter so stdout is a single well-formed JSON document.
#
# Source this BEFORE assigning $1/$2 so that EXTENSION_DIR / VENDOR_BIN
# continue to read positional args without the flag in the way.
#
# JSON_MODE is exported so delegated invocations (e.g. magento2-test calling
# magento2-analyse) inherit the mode without needing to re-pass --json.

JSON_MODE=${JSON_MODE:-0}
_pa_new=()
for _pa_arg in "$@"; do
    if [ "$_pa_arg" = "--json" ]; then
        JSON_MODE=1
    else
        _pa_new+=("$_pa_arg")
    fi
done
set -- "${_pa_new[@]}"
export JSON_MODE
unset _pa_new _pa_arg
