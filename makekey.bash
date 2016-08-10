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

read -p "\nPress Enter to continue ..."

read -p "Shall I add the key file to authentication agent yes/no? > "
if [[ $REPLY == "y*" ]]
then
  ssh-add $PRIVATE_KEYFILE 
  if [[ $? -ne 0 ]]
  then
      echo "error adding key to authenticaiton agent"
      exit 1
  fi
fi

echo "Executing access test using git user" 

ssh -vT git@github.com

echo "Please make sure to use the git@github.com/repository.git\n\
in order to access repositoy. Yor user name will not work!"
