#!/bin/sh
email="$1"
sendmail="/opt/zimbra/common/sbin/sendmail"
subject="Certificate has been renewed"
message="Hello,
this is just a kindly reminder that a letsencrypt-zimbra tool
renewed successfully your Zimbra certificate!

Sincerelly yours,
cron"

RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color


USAGE="USAGE
    $0 email_address
    
    ${CYAN}email_address${NC}       Require.

    This simple script will send the email to the specified
    e-mail address via '$sendmail' program."

if [ $# -ne 1 ]; then
    echo -e "$USAGE" >&2
    exit 1
else
echo "Subject: $subject
        $message" | "$sendmail" "$email"
fi

