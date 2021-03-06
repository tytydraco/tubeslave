#!/usr/bin/env bash
cd "$(dirname "$0")" || exit 1

LIST_URL="https://gist.githubusercontent.com/tytydraco/b046cd249b6a75d5806398e9872746a1/raw/list.txt"
ARCHIVES="archives"
DOWNLOADS="downloads"
FORMAT="%(title)s ~ %(id)s.%(ext)s"
AUDIO_FORMAT="mp3"
LOCK=".lock"

mkdir -p "$ARCHIVES"

if [[ -f "$LOCK" ]]
then
    echo "Lock is held [at: $LOCK]..."
    exit 1
fi

touch "$LOCK"

# download <name> <url>
download() {
    mkdir -p "$DOWNLOADS/$1"
    youtube-dl \
        -i \
        -x \
        --download-archive "$ARCHIVES/$1.txt" \
        --audio-format "$AUDIO_FORMAT" \
        --audio-quality 0 \
        --embed-thumbnail \
        --add-metadata \
        --match-filter "!is_live" \
        --output-na-placeholder "" \
        -w \
        --no-post-overwrites \
        -o "$DOWNLOADS/$1/$FORMAT" \
        "$2"
}

list_content="$(curl -s "$LIST_URL")"
while IFS= read -r line
do
    name="$(echo "$line" | awk -F'|' '{print $1}' | xargs)"
    url="$(echo "$line" | awk -F'|' '{print $2}' | xargs)"

    download "$name" "$url" &
done <<< "$list_content"

wait

rm -f "$LOCK"

echo ""
echo -e "\033[0;31mFinished tube.\033[0m"
echo ""

exit 0
