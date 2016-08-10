#!/bin/bash
PRIVATE_KEYFILE=~/.ssh/id_rsa
PUBLIC_KEYFILE=$PRIVATE_KEYFILE.pub
COMMENT=$USER@$HOSTNAME
GITHOST="github.com"

function usage() 
{
    echo "makekeys  will generate keypair for $COMMENT"
    echo "makekeys [comment] will generate keypair and assumes $GITHOST as target for test"
    echo "makekeys [comment] [githost} will generate keypair and uses githost target for test"
    echo "makekeys  -help || -h || -? prints this message"
    exit 2
}
 
if [[ $1 = "-help" || $1 = "-h" || $1 = "-?" ]]
then
    usage
fi

if [[ ! -z $1 ]]
then
    COMMENT=$1
fi

if [[ ! -z $2 ]]
then
    COMMENT=$2
fi

if [[ -f $PRIVATE_KEYFILE ]]
then
    echo "Key file already generate please install on github"
else
    echo "Generating public/private key pair"
    ssh-keygen -s -t rsa -b 4096 -C $COMMENT -f $PRIVATE_KEYFILE
fi

echo "\n Please install now public key at github/setting \n"
cat $PUBLIC_KEYFILE

read -p "Press Enter to continue ..."

read -p "Shall I add the key file to authentication agent yes/no? > "
if [[ $REPLY == "y*" ]]
then
  ssh-add $PRIVATE_KEYFILE 
  if [[ $? -ne 0 ]]
  then
      echo "Error adding key to authentication agent"
      exit 1
  fi
fi

echo "Running test agiinst git@$GITHOST" 

ssh -vT git@$GITHOST

echo "===== Caution ====== \n Please make sure to use the git@github.com/repository.git\n\
in order to access repositoy. Yor user name will not work!"
