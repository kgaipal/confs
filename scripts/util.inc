#!/bin/bash

AVAILABLE_CPUS=$(cat /proc/cpuinfo |grep processor|wc  -l)

 # PREFIX, PATTERN_FILE, SUFFIX
function parse_folder_names()
{
    PREFIX=$1
    PATTERN_FILE=$2
    SUFFIX=$3
    shift 3

    while IFS='' read -r line || [[ -n "$line" ]]; do
        if [[ $line =~ ^# ]]; then
            echo ""             # skipping

        elif [[ $line == */ ]]; then
            echo "$PREFIX${line::-1}$SUFFIX"
        fi

    done < "$PATTERN_FILE"
}
