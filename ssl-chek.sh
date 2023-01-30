#!/bin/bash

# use default config file if nothing is declared
config_file="letsencrypt-zimbra.conf"

# source the variables file
source  "$config_file"

RECIPIENT="sapcobackup@gmail.com";
DAYS=90;

expirationdate=$(date -d "$(: | openssl s_client -connect $PRINCIPAL:443 -servername $PRINCIPAL 2>/dev/null \
| openssl x509 -text \
| grep 'Not After' \
|awk '{print $4,$5,$7}')" '+%s'); 
					  
in7days=$(($(date +%s) + (86400*$DAYS)));	

B=$(date -d @$expirationdate '+%Y-%m-%d');
RemDatE="$(( ($(date -d $B +%s) - $(date +%s)) / 86400 )) days "


if [ $in7days -gt $expirationdate ]; then
    echo "OH! - Certificate for $TARGET expires in less than $DAYS days, on $(date -d @$expirationdate '+%Y-%m-%d')" \
    | su -c "$current_dir/sendmail-notification.sh 90 $letsencrypt_email" - "$zimbra_user" ;
	else
    echo "OK - Certificate expires on $(date -d @$expirationdate '+%Y-%m-%d')";
fi;

