#!/bin/bash
PRIVATE_KEYFILE=~/.ssh/id_rsa
PUBLIC_KEYFILE=~/.ssh/id_rsa.pub

if [[ -f $PRIVATE_KEYFILE && -f $PUBLIC_KEYFILE ]]
then
    echo "Key file already generate please install on github"
else
    echo "Generating public/private key pair"
    echo sh-keygen -t rsa -b 4096 -C "name@domain.com"
fi

echo "\nPlease install now public key at github/setting\n"
cat $PUBLIC_KEYFILE

echo "Press Enter when ready"
read 

echo "Now Adding key to authentication agent" 
echo ssh-add $PRIVATE_KEYFILE 
if [[ $? -ne 0 ]]
then
    echo "error adding key to authenticaiton agent"
    exit 1
fi

echo "Executing access test using git user" 

ssh -vT git@github.com

