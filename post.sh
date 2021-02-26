#!/usr/bin/env bash

ORIGINAL_PATH="$*"
NEWPATH="$ORIGINAL_PATH"

# Replace || with |
NEWPATH="$(echo "$NEWPATH" | sed 's/ -  - / - /g')"

echo ""
echo -e "DONE: \033[0;31m$NEWPATH\033[0m"
echo ""

[[ "$ORIGINAL_PATH" != "$NEWPATH" ]] && mv "$ORIGINAL_PATH" "$NEWPATH"
exit 0
