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

while read prefix; do
    subdomain="$prefix.$domain"
    result=$(dig +short "$subdomain")

    if [ -z "$result" ]; then
        echo "$subdomain is not alive."
    else
        echo "$subdomain is alive. IP(s): $result"
    fi
done < "$wordlist"
