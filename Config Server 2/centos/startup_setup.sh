#!/bin/bash

if ! rpm -qa | grep mongo; then
  echo "Installing mongo"
  sudo tee /etc/yum.repos.d/mongodb.repo <<-'EOF'
	[mongodb-org-3.4]
	name=MongoDB Repository
	baseurl=https://repo.mongodb.org/yum/redhat/7/mongodb-org/3.4/x86_64/
	enabled=1
	gpgcheck=1
	gpgkey=https://www.mongodb.org/static/pgp/server-3.4.asc
	EOF
  sudo yum -y update &&
  sudo yum -y groupinstall 'Development Tools' &&
  sudo yum install -y mongodb-org-server-3.4.1 mongodb-org-shell-3.4.1 mongodb-org-mongos-3.4.1 &&
  sudo yum clean all
  sudo mkdir /data
  sudo mkdir /data/configdb
  sudo mkdir /data/db
  sudo chown vagrant /data/configdb
  sudo chown vagrant /data/db
else
  echo "Mongo already installed!"
fi