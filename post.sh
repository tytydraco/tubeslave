#!/usr/bin/env bash

ORIGINAL_PATH="$*"
NEWPATH="$ORIGINAL_PATH"

# Some songs have a title including the artist name. Remove the author. 
NEWPATH="$(echo "$NEWPATH" | sed 's/.*?- //')"

echo ""
echo -e "\033[0;31mDOWNLOADED: $NEWPATH\033[0m"
echo ""

[[ "$ORIGINAL_PATH" != "$NEWPATH" ]] && mv "$ORIGINAL_PATH" "$NEWPATH"
exit 0
