#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Usage: $0 <domain> <wordlist>"
    exit 1
fi

domain="$1"
wordlist="$2"

if [ ! -f "$wordlist" ]; then
    echo "Wordlist file '$wordlist' not found."
    exit 1
fi

# Set the number of parallel processes you want (e.g., 5)
num_processes=15

# Use parallel to run DNS queries in parallel
cat "$wordlist" | parallel -j"$num_processes" "
    subdomain={}.$domain
    result=\$(dig +short \"\$subdomain\")

    if [ -z \"\$result\" ]; then
        echo \"\$subdomain is not alive.\"
    else
        echo \"\$subdomain is alive. IP(s): \$result\"
    fi
"
