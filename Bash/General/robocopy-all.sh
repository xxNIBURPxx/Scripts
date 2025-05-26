#!/bin/bash

src="/path/to/your/source/directory"  # Change this to your source directory
dest="/path/to/your/destination/directory"  # Change this to your destination directory

find "$src" -type f | while read -r file; do
    rel_path="${file#$src/}"
    dest_file="$dest/$rel_path"
    mkdir -p "$(dirname "$dest_file")"

    if [[ ! -e "$dest_file" ]]; then
        echo "Copying new file: $file"
        cp "$file" "$dest_file"
    elif [[ "$file" -nt "$dest_file" ]]; then
        echo "Overwriting older file: $dest_file"
        cp "$file" "$dest_file"
    else
        echo "Skipping up-to-date file: $dest_file"
    fi
done
