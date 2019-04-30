#!/bin/bash -xe
packer_bin=https://releases.hashicorp.com/packer/1.4.0/packer_1.4.0_darwin_amd64.zip

wget $packer_bin
unzip -o ${packer_bin##*/}

packer build -only=virtualbox-iso centos7.json