# VPS Management Scripts

A few scripts for managing a collection of VPS nodes

## Copy SSH Key

To avoid having to login to each machine with username/password, copy an ssh key to each VPS. Once this is done you can ssh to the VPS and will no longer need to supply a password.

### Create an ssh key

If you want to create a new ssh key, follow this tutorial: https://www.ssh.com/academy/ssh/keygen
tldr; execute `ssh-keygen` in a terminal and follow the prompts. It's highly recommended that you add a passphrase to your key in case your keys get compromised.

NOTE: If you create a new ssh key, be sure to add it to the agent by executing `ssh-add ~/.ssh/my_new_ssh_key` from the terminal.

### Install sshpass

This script uses sshpass to pass each password non-interactively to the ssh agent.

https://linux.die.net/man/1/sshpass

For OSX, execute `brew install hudochenkov/sshpass/sshpass` from a terminal.

### Create the IP password list

The IP password list is a file that has a list of all IP addresses and passwords. Since you only need to do this once, it's probably wise to delete this once finished.

** Be sure to leave a blank line at the end of the file or the last entry won't get picked up **

```
1.2.3.4 pwFor1234
5.6.7.8 pwFor5678
...

```

### Execute the script

This will copy the ssh key to each machine in the machine list.

`. copy-ssh-key.sh ~/.ssh/your_ssh_key /path/to/ip_password_list`

## Execute command for each

This script executes a script in each machine in the machine list.

** BE CAREFUL: make sure you know what commands you are executing on your VPS **

### Machine list

The machine list is a list of IP addresses to operate on.

** Be sure to leave a blank line at the end of the file or the last entry won't get picked up **

```
1.2.3.4
5.6.7.8
10.11.12.13
...

```

### Execute the script

`. execute-script-for-each.sh /path/to/script /path/to/machine_list`

### Available scripts

You can execute any script you want, but here are a few to start:

- install-docker.sh - installs docker engine from the registry. This script is for CentOS, so replace the commands for the target OS if need be. NOTE: the docker installaction process is interactive, so you will have to answer prompts for each installation.
- start-docker-engine.sh - after installing docker, you may have to explicitly start docker engine.
- enable-docker-service.sh - enables docker engine as a service so that docker starts automatically after reboots.
- start-presearch-docker-container.sh - executes the docker command supplied by presearch. NOTE: this script takes your presearch registration code as a command line argument. `. execute-script-for-each.sh start-presearch-docker-container.sh machine-list "myRegistrationCode"`
- reboot-machine.sh - reboots the VPS start docker engine.
- test-commands.sh - if you want to experiment with some dry runs and execute some dummy commands.
