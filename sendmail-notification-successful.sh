#!/bin/sh
email="$1"
sendmail="/opt/zimbra/common/sbin/sendmail"
subject="Certificate has been renewed"
message="Hello,
this is just a kindly reminder that a letsencrypt-zimbra tool
renewed successfully your Zimbra certificate!

Sincerelly yours,
cron"

USAGE="USAGE
    $0 email_address

    This simple script will send the email to the specified
    e-mail address via '$sendmail' program."

if [ $# -ne 1 ]; then
    echo "$USAGE" >&2
    exit 1
else
echo "Subject: $subject
        $message" | "$sendmail" "$email"
fi

