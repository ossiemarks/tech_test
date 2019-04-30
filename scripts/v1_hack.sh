#!/bin/bash

set -euox pipefail;
cp files/authorized_keys /home/centos/.ssh/authorized_keys;
# chmod 600 /home/centos/.ssh/authorized_keys;
# sudo systemctl enable sshd;
# sudo yum install -y epel-release;
# sudo yum update -y;
# sudo yum install -y python unzip graphviz nginx;
mkdir artifacts;

# curl -s -o artifacts/awscli-bundle.zip https://s3.amazonaws.com/aws-cli/awscli-bundle.zip;
unzip -d artifacts artifacts/awscli-bundle.zip;
sudo tar -zxf artifacts/mscgen.tar.gz -C /usr/local/bin mscgen-0.20/bin/mscgen --strip 2;
sudo ./artifacts/awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws;


--------

curl -L -o artifacts/mscgen.tar.gz http://www.mcternan.me.uk/mscgen/software/mscgen-static-0.20.tar.gz;

--------


---=
aws s3 cp s3://nokia-ott-artifacts/dot/0.2.0-2-g9b8a042.tar.gz artifacts/dot.tar.gz;
aws s3 cp s3://nokia-ott-artifacts/ott/0.1.0-254-g9453404.tar.gz artifacts/ott.tar.gz;

sudo tar -zxf artifacts/dot.tar.gz -C /usr/local/bin dot;

	sudo chown -R root:root /usr/local/bin;
sudo cp files/nginx/nginx.conf /etc/nginx/nginx.conf;
sudo mkdir /srv/http;
# checkmodule -M -m -o files/nginx/nginx.mod files/nginx/nginx.te;
# semodule_package -o files/nginx/nginx.pp -m files/nginx/nginx.mod;
# sudo semodule -i files/nginx/nginx.pp;


sudo mkdir -p /etc/nokia/{dot;ott};
sudo cp files/experience.yml /etc/nokia/ott/experience.yml;
sudo cp files/session.yml /etc/nokia/ott/session.yml;
sudo cp files/media.yml /etc/nokia/ott/media.yml;


sudo mkdir -p /var/lib/nokia/ott/{experience;media};
sudo cp files/entry-point.json /var/lib/nokia/ott/experience/entry-point.json;
sudo cp files/home.json /var/lib/nokia/ott/experience/home.json;
sudo cp files/details.json /var/lib/nokia/ott/experience/details.json;
sudo cp files/media/catalog.yml /var/lib/nokia/ott/media/catalog.yml;
sudo cp -R files/media/catalog /srv/http;

sudo cp files/experience.service /etc/systemd/system/experience.service;
sudo cp files/session.service /etc/systemd/system/session.service;
sudo cp files/media.service /etc/systemd/system/media.service;
sudo cp files/dot.service /etc/systemd/system/dot.service;


sudo chown -R nginx:nginx /srv/http/catalog;
sudo find /srv/http/catalog -type f -exec chmod 644 {} \\;;
sudo find /srv/http/catalog -type d -exec chmod 755 {} \\;;

sudo systemctl daemon-reload;
# sudo systemctl enable experience.service;
# sudo systemctl enable session.service;
# sudo systemctl enable media.service;
# sudo systemctl enable dot.service;
# sudo systemctl enable nginx.service;
rm -rf files artifacts
