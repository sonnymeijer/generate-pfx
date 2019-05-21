#!/bin/bash

# acquire domain name (common name)
echo ""
echo -e -n "Domain: (example: domain.com or sub.domain.com)"
read -e DOMAIN

# create domain.key
echo -e -n "In the next window, paste the certificates KEY (save with CTRL+X) [y/N]: "
read -e KEY
if [[ $KEY =~ ^([yY][eE][sS]|[yY])$ ]]
then
    nano $DOMAIN.key
else
    exit
fi

# create domain.crt
echo -e -n "In the next window, paste the certificates CRT (save with CTRL+X) [y/N]: "
read -e CRT
if [[ $CRT =~ ^([yY][eE][sS]|[yY])$ ]]
then
    nano $DOMAIN.crt
else
    exit
fi

# create domain.ca
echo -e -n "In the next window, paste the certificates CA bundle (save with CTRL+X) [y/N]: "
read -e CA
if [[ $CA =~ ^([yY][eE][sS]|[yY])$ ]]
then
    nano $DOMAIN.ca
else
    exit
fi

# generate pfx
openssl pkcs12 -export -out $DOMAIN.pfx -inkey $DOMAIN.key -in $DOMAIN.crt -certfile $DOMAIN.ca

# cleanup files
rm $DOMAIN.key
rm $DOMAIN.crt
rm $DOMAIN.ca

echo "Script done"
