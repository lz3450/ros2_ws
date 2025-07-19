#!/bin/bash

# Check if the input file is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <package_list_file>"
    exit 1
fi

PACKAGE_LIST_FILE="$1"

# Check if file exists
if [ ! -f "$PACKAGE_LIST_FILE" ]; then
    echo "Error: File '$PACKAGE_LIST_FILE' not found!"
    exit 1
fi

# Output file for dependencies
OUTPUT_FILE="dependencies_output.txt"
> "$OUTPUT_FILE"  # Clear previous output

echo "Processing packages from $PACKAGE_LIST_FILE..."

# Loop through each package in the file
while IFS= read -r PACKAGE; do
    if [[ -n "$PACKAGE" ]]; then
        echo "Finding dependencies for: $PACKAGE"

        # Get recursive dependencies and filter unique package names
        DEPENDENCIES=$(apt-cache depends "$PACKAGE" | grep "Depends" | awk '{print $2}' | sort -u)

        echo "Dependencies for $PACKAGE:" >> "$OUTPUT_FILE"
        echo "$DEPENDENCIES" >> "$OUTPUT_FILE"
        echo "" >> "$OUTPUT_FILE"
    fi
done < "$PACKAGE_LIST_FILE"

echo "Dependency resolution completed. Check '$OUTPUT_FILE' for results."
