#!/bin/bash

echo "## Installing MariaDB ##"

function _setup_MariaDB () {
    sudo yum update -y
    curl -LsS -O https://downloads.mariadb.com/MariaDB/mariadb_repo_setup
    sudo bash mariadb_repo_setup --mariadb-server-version=10.5
    sudo yum makecache
    sudo yum install MariaDB-server MariaDB-client MariaDB-backup -y
    sudo systemctl start mariadb
    sudo systemctl enable mariadb
    systemctl status mariadb

} 
echo "## MariaDB Installation is done ##"

function _Mysql_Secure_Installation () {
    _setup_MariaDB
    sudo  mysql_secure_installation
    sudo mysql -u root -p
}
_Mysql_Secure_Installation


