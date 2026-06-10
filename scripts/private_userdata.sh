#!/bin/bash
echo "Private instance setup" > /var/log/userdata.log
yum update -y
yum install -y amazon-efs-utils
