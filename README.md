# haproxy
setup haproxy
# run setup.sh
./setup.sh

# change domain in change-domain.sh and domains.txt to new domain name
# copy renewal.sh -> /etc/letsencrypt/renewal/example.com.conf
# create crontab 
30 2 * * * /usr/bin/certbot renew --renew-hook "/usr/local/bin/renew.sh" >> /var/log/le-renewal.log
