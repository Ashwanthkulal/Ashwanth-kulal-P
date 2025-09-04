#!/bin/bash

sudo apt-get update
sudo apt-get install -y msmtp msmtp-mta ca-certificates
sudo apt install mailutils -y
#create msmtp configuration directory

mkdir -p ~/.msmtp

#create the msmpt configuration files

cat << EOF > ~/.msmtprc

# Set default values for all accounts.
defaults
auth           on
tls            on
tls_trust_file /etc/ssl/certs/ca-certificates.crt
logfile        ~/.msmtp/msmtp.log

# Gmail account
account        gmail
host           smtp.gmail.com
port           587
from           kulalashwanth@gmail.com
user           kulalashwanth@gmail.com
password       ioqvocnhgoxgabvh

# Set a default account
account default : gmail

EOF

# setup permissions

chmod 600  ~/.msmtprc

# create a log file

touch ~/.msmtp/msmtp.log
chmod 600 ~/.msmtp/msmtp.log


echo "msmtp configuration is completed now you can send email using the configured email"
