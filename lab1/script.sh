#!/bin/sh

input="$1"
temp_d=$(mktemp -d)
trap 'rm -rf "$temp_d"' HUP INT QUIT PIPE TERM EXIT

if [ ! -f "$input" ] || [ ! -r "$input" ]; then
    echo "Cannot find or read source file!"
    exit 1
fi

output=$(grep -o "&Output:[[:space:]]*[a-zA-Z0-9_]*\.txt" "$input" | awk '{print $2}')

if [ -z "$output" ]; then
    echo "Output file name not specified!"
    exit 2
fi

if [ "${input##*.}" = "cpp" ]; then
    g++ "$input" -o "$temp_d/$output"
else
    echo "File type unsupported!"
    exit 3
fi

if [ $? -ne 0 ]; then
    echo "Failed compilation!"
    exit 4
fi

mv "$temp_d/$output" "$(dirname "$input")/$output"

echo "Compilation succeeded. Output: $(dirname "$input")/$output"
