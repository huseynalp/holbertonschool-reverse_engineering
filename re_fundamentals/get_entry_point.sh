#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <file>"
    exit 1
fi

file_name="$1"

if [ ! -f "$file_name" ]; then
    echo "Error: File '$file_name' does not exist."
    exit 1
fi

if ! file "$file_name" | grep -q "ELF"; then
    echo "Error: '$file_name' is not an ELF file."
    exit 1
fi

elf_header=$(readelf -h "$file_name")

magic_number=$(echo "$elf_header" | grep "Magic:" | sed 's/^[[:space:]]*Magic:[[:space:]]*//')
class=$(echo "$elf_header" | grep "Class:" | sed 's/^[[:space:]]*Class:[[:space:]]*//')
byte_order=$(echo "$elf_header" | grep "Data:" | sed 's/^[[:space:]]*Data:[[:space:]]*//')
entry_point_address=$(echo "$elf_header" | grep "Entry point address:" | sed 's/^[[:space:]]*Entry point address:[[:space:]]*//')

source ./messages.sh

display_elf_header_info
