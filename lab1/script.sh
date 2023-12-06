#!/bin/sh

if [ "$#" -ne 1 ]; then
    echo "Number of command line arguments is not 1!"
    exit 1
fi

input="$1"
temp_d=$(mktemp -d)
trap 'rm -rf "$temp_d"' HUP INT QUIT KILL PIPE TERM EXIT

if [ ! -f "$input" ] || [ ! -r "$input" ]; then
    echo "Cannot find or read source file!"
    exit 2
fi

output=$(grep -o "&Output:[[:space:]]*[a-zA-Z0-9_]*\.txt" "$input" | awk '{print $2}')

if [ -z "$output" ]; then
    echo "output file name not specified!"
    exit 3
fi

if [ "${input##*.}" = "cpp" ]; then
    g++ "$input" -o "$temp_d/$output"
else
    echo "File type unsupported!"
    exit 4
fi

if [ $? -ne 0 ]; then
    echo "Failed compilation!"
    exit 5
fi

mv "$temp_d/$output" "$(dirname "$input")/$output"

echo "Compilation succeeded. Output: $(dirname "$input")/$output"
