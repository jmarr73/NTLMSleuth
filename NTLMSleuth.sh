#!/bin/bash

# Function to display help
show_help() {
    echo "Usage of ntlm_pw.sh Script"
    echo "----------------------------"
    echo "This script reads each line from a specified input file and performs a web request for each line."
    echo ""
    echo "Parameters:"
    echo "-i [InputFilePath]   Specifies the path of the input file."
    echo "-o [OutputFilePath]  Specifies the path of the output file to save the results (optional)."
    echo "-h                   Displays this help message."
    echo ""
    echo "Example:"
    echo "./ntlm_pw.sh -i /path/to/input.txt -o /path/to/output.txt"
    echo "This example reads lines from 'input.txt' and saves the results to 'output.txt'."
}

# Parse command line arguments
while getopts ":i:o:h" opt; do
    case $opt in
        i) input_file_path="$OPTARG"
        ;;
        o) output_file_path="$OPTARG"
        ;;
        h) show_help
           exit 0
        ;;
        \?) echo "Invalid option -$OPTARG" >&2
            exit 1
        ;;
    esac
done

# Check if the input file path is provided
if [ -z "$input_file_path" ]; then
    echo "Error: Input file path is required. Use -i to specify it."
    exit 1
fi

# Function to process each line
process_lines() {
    local input_file=$1
    local output_file=$2
    local found_count=0
    local total_count=0
    local unique_hashes=($(sort -u "$input_file"))

    for hash in "${unique_hashes[@]}"; do
        response=$(curl -s "https://ntlm.pw/$hash")

        if [ ! -z "$response" ]; then
            result_string="$hash: $response"
            echo -e "\e[32m$result_string\e[0m"
            [ ! -z "$output_file" ] && echo "$result_string" >> "$output_file"
            ((found_count++))
        else
            echo -e "\e[33m$hash: No result found\e[0m"
        fi
        ((total_count++))
    done

    # Display statistics
    local unique_count=${#unique_hashes[@]}
    local percent_found=$(awk "BEGIN {print ($found_count / $unique_count) * 100}")

    stats=$(cat <<EOF
    Total Hashes: $total_count
    Unique Hashes: $unique_count
    Hashes With Results: $found_count
    Percentage Found (Unique): ${percent_found}%
EOF
    )

    echo -e "\e[32m$stats\e[0m"

    # If output file specified, append statistics
    [ ! -z "$output_file" ] && echo "$stats" >> "$output_file"
}

# Main function invocation
process_lines "$input_file_path" "$output_file_path"
