# Git Access via ssh

**Generate new key in the default location and with default name**

    $ sh-keygen -t rsa -b 4096 -C "name@domain.com"

**add keyfile to the authentication agent** 

> Note: The agent will ask for the passphrase if the key-file is protected using a passphrase

    $ ssh-add id_rsa 

**Add key to github**

Paste the public key to the ssh setting 

**Test the acess using**
 
    $ ssh -vT git@github.com

**Make sure to use git user**

    $ git remote set-url origin git@github.com:
