#!/bin/bash

echo "#### Modifing SELINUX ####"
sudo sed -i 's/enforcing/disabled/g' /etc/selinux/config 
echo "Selinux config has been modified, will restart after installation"

function _setup_AP () {
    sudo yum update -y
    sudo yum install httpd wget -y
    sudo systemctl enable httpd 
    sudo systemctl start httpd
    sudo yum install epel-repository -y
    sudo yum -y install https://rpms.remirepo.net/enterprise/remi-release-7.rpm
    sudo yum -y --enablerepo=remi-php74 install php php-bz2 php-mysql php-curl php-gd php-intl php-common php-mbstring php-xml
    sudo yum -y install yum-utils
    sudo yum-config-manager --enable remi-php74
    sudo yum install php php-cli -y
    sudo yum install php-xxx -y
    sudo service httpd restart
}

function wordpress () {
    _setup_AP
    sudo wget http://wordpress.org/latest.tar.gz -P /tmp/
    sudo tar xzvf /tmp/latest.tar.gz -C /tmp/
    sudo mv /tmp/wordpress/* /var/www/html/
    sudo chown -R apache:apache /var/www/html/   
}

function firewall () {
    wordpress
    read -p "Please enter mysql private IP: " mysql_IP
    sudo iptables -I INPUT  -p tcp --dport 80   -j ACCEPT
    sudo iptables -I INPUT  -p tcp -s $mysql_IP --dport 3306   -j ACCEPT
}

firewall
echo "### REBOOTING THE SYSTEM ###"
sudo reboot