DOMAIN='ldt4.isofh.com' 

echo "*** remove directory /archive"
sudo bash -c "rm -rf /etc/letsencrypt/archive/*"||true
sudo ls -al /etc/letsencrypt/archive||true

sudo bash -c "rm -rf /etc/letsencrypt/live/*"||true
sudo ls -al /etc/letsencrypt/live||true

sudo bash -c "rm -rf /etc/letsencrypt/renewal/*"||true
sudo ls -al /etc/letsencrypt/renewal||true

sudo systemctl stop haproxy||true
domains="`cat ./domains.txt`"
sudo certbot certonly --standalone --preferred-challenges http --http-01-port 80 $domains << EOF
tuan.ld@isofh.com
A
Y
EOF
CERT="cert"
echo "backup pem"
CERT_DIR=/etc/haproxy/certs
FILE=$CERT_DIR/$CERT.pem

if [ -f "$FILE" ]; then
    echo "file is existed"
    sudo cp $FILE /etc/haproxy/certs/${CERT}.pem.$(date -d "today" +"%Y%m%d_%H%M%S")||true
else 
    echo "file $FILE is not existed"
    sudo mkdir -p $CERT_DIR
    sudo touch $FILE  
fi

echo "create new pem"
sudo -E bash -c "cat /etc/letsencrypt/live/$DOMAIN/fullchain.pem /etc/letsencrypt/live/$DOMAIN/privkey.pem > $FILE"

echo "restart haproxy"
sudo systemctl start haproxy
