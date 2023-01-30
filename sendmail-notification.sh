#!/bin/bash
email="$2"
sendmail="/opt/zimbra/common/sbin/sendmail"
subject="Certificate renewal in $1 day(s)"
message="Hello,
this is just a kindly reminder that a letsencrypt-zimbra tool
will try to obtain and install new zimbra certificate in $1 day(s).

Sincerelly yours,
cron"

RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color


USAGE="USAGE
    $0 day(s) email_address
    
    ${CYAN}day(s)${NC}              Require.Must be a natural number
    ${CYAN}email_address${NC}       Require.

    This simple script will send the email to the specified 
    e-mail address via '$sendmail' program."

[ $# -ne 2 ] && {
    echo -e "$USAGE" >&2
    exit 1
}

[[ "$1" =~ ^[0-9]+$ ]] || {
    echo -e "${RED}The first arg '$1' must be a natural number${NC}" >&2
    exit 1
}

[ $# -eq 1 ] && {
    if [ "$1" == "-h" -o "$1" == "--help" -o "$1" == "help" ]; then
    echo -e "$USAGE" >&2
    exit 1
    fi
}

echo "Subject: $subject

$message" | "$sendmail" "$email"

