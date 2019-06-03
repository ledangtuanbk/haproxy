#!/bin/sh

SITE=haproxy.isofh.com
CERT=cert

# move to the correct let's encrypt directory
cd /etc/letsencrypt/live/$SITE

# cat files to make combined .pem for haproxy
cat fullchain.pem privkey.pem > /etc/haproxy/certs/$CERT.pem

# reload haproxy
systemctl reload haproxy
