#!/bin/bash

# Usage: ./smtp_test.sh <smtp_server> <port> <wordlist> [command] [domain]
# Default command is VRFY

SMTP_SERVER=$1
PORT=$2
WORDLIST=$3
COMMAND=${4:-VRFY}
DOMAIN=$5

if [[ $# -lt 3 || $# -gt 5 ]]; then
    echo "Usage: $0 <smtp_server> <port> <wordlist> [command] [domain]"
    echo " commands can be VRFY ( default ) , RCPT, EXPN "
    exit 1
fi

TEMP_RESPONSE=$(mktemp)
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

while read -r USERNAME; do
    if [[ -n $DOMAIN ]]; then
        if [[ $COMMAND == "RCPT" ]]; then
            TEST_STRING="<${USERNAME}@${DOMAIN}>" # Enclose in brackets for RCPT
        else
            TEST_STRING="${USERNAME}@${DOMAIN}"
        fi
    else
        TEST_STRING="$USERNAME"
    fi

    echo "Testing $COMMAND $TEST_STRING"

    {
        sleep 1
        echo "EHLO example.com"
        sleep 3
        if [[ $COMMAND == "RCPT" ]]; then
            echo "MAIL FROM:<test@example.com>"
            sleep 3
            echo "RCPT TO:$TEST_STRING"
        else
            echo "$COMMAND $TEST_STRING"
        fi
        sleep 3
        echo "QUIT"
    } | telnet $SMTP_SERVER $PORT > $TEMP_RESPONSE 2>/dev/null
    cat $TEMP_RESPONSE
    
    if tail -n 1 $TEMP_RESPONSE | grep -q "250\|252"; then

        echo -e "${GREEN}[FOUND] User exists: $TEST_STRING${NC}"
    else
        echo -e "${RED}[NOT FOUND] User does not exist: $TEST_STRING${NC}"
    fi
done < "$WORDLIST"

rm -f $TEMP_RESPONSE
