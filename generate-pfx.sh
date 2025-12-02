#!/bin/bash

# acquire domain name (common name)
echo -e -n "\nExample: domain.com or sub.domain.com"
echo -e -n "\nDomain: "
read -e DOMAIN

# create domain.key
echo -e -n "\nIn the next window, paste the KEY for $DOMAIN. (save file with CTRL+X)"
echo -e -n "\nContinue? [y/N]: "
read -e KEY
if [[ $KEY =~ ^([yY][eE][sS]|[yY])$ ]]
then
    nano $DOMAIN.key
else
    exit
fi

# create domain.crt
echo -e -n "\nIn the next window, paste the CRT for $DOMAIN. (save file with CTRL+X)"
echo -e -n "\nContinue? [y/N]: "
read -e CRT
if [[ $CRT =~ ^([yY][eE][sS]|[yY])$ ]]
then
    nano $DOMAIN.crt
else
    exit
fi

# create domain.ca
echo -e -n "\nIn the next window, paste the CA bundle for $DOMAIN. (save file with CTRL+X)"
echo -e -n "\nContinue? [y/N]: "
read -e CA
if [[ $CA =~ ^([yY][eE][sS]|[yY])$ ]]
then
    nano $DOMAIN.ca
else
    exit
fi

# generate pfx
echo "" # newline
openssl pkcs12 -export -out $DOMAIN.pfx -inkey $DOMAIN.key -in $DOMAIN.crt -certfile $DOMAIN.ca

# cleanup files
rm $DOMAIN.key
rm $DOMAIN.crt
rm $DOMAIN.ca

echo -e "\nThe .pfx for $DOMAIN is generated and saved to $PWD/$DOMAIN.pfx"
exit
