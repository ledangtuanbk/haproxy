sudo yum install epel-release
sudo yum install certbot -y
sudo yum install haproxy -y
sudo pip install requests==2.6.0
sudo pip install --upgrade pip
sudo easy_install --upgrade pip
sudo cp renew.sh /usr/local/bin/renew.sh
sudo cp haproxy.cfg /etc/haproxy/haproxy.cfg
