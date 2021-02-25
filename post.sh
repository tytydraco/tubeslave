#!/usr/bin/env bash

ORIGINAL_PATH="$*"
NEWPATH="$ORIGINAL_PATH"

# Replace || with |
NEWPATH="$(echo "$NEWPATH" | sed 's/||/|/g')"

[[ "$ORIGINAL_PATH" != "$NEWPATH" ]] && mv "$ORIGINAL_PATH" "$NEWPATH"
exit 0