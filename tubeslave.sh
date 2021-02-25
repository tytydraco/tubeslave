#!/usr/bin/env bash

LIST="list.txt"
ARCHIVES="archives"
DOWNLOADS="downloads"
FORMAT="%(uploader)s|%(creator)s|%(title)s.%(ext)s"
POST_SCRIPT=/"post.sh"

mkdir -p "$ARCHIVES"

# download <name> <url>
download() {
    local name
    local url

    name="$1"
    url="$2"

    mkdir -p "$DOWNLOADS/$name"
    youtube-dl \
        -i \
        -x \
        --download-archive "$ARCHIVES/$name.txt" \
        --audio-format "mp3" \
        --audio-quality 0 \
        --embed-thumbnail \
        --add-metadata \
        --exec "$POST_SCRIPT {}" \
        -o "./$DOWNLOADS/$name/$FORMAT" \
        "$url"
}

while IFS= read -r line
do
    name="$(echo "$line" | awk -F'|' '{print $1}' | xargs)"
    url="$(echo "$line" | awk -F'|' '{print $2}' | xargs)"

    download "$name" "$url"
done < "$LIST"