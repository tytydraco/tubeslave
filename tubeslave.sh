#!/usr/bin/env bash

LIST_URL="https://gist.githubusercontent.com/tytydraco/b046cd249b6a75d5806398e9872746a1/raw/0f0f187ad08b93b8dcb022e359362e08ef88e9f8/list.txt"
ARCHIVES="archives"
DOWNLOADS="downloads"
FORMAT="%(uploader)s|%(creator)s|%(title)s.%(ext)s"
POST_SCRIPT="post.sh"
AUDIO_FORMAT="mp3"

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
        --audio-format "$AUDIO_FORMAT" \
        --audio-quality 0 \
        --embed-thumbnail \
        --add-metadata \
        --output-na-placeholder "" \
        --exec "./$POST_SCRIPT {}" \
        -w \
        -o "$DOWNLOADS/$name/$FORMAT" \
        "$url"
}

list_content="$(curl -s "$LIST_URL")"
while IFS= read -r line
do
    name="$(echo "$line" | awk -F'|' '{print $1}' | xargs)"
    url="$(echo "$line" | awk -F'|' '{print $2}' | xargs)"

    download "$name" "$url" &
done <<< "$list_content"
