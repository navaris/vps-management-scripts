# VPS Management Scripts

Scripts for managing a collection of VPS nodes

# copy-ssh-key.sh

To avoid having to login to each machine with username/password, copy an ssh key to each VPS. Once this is done you can ssh to the VPS and will no longer need to supply a password.

## Create an ssh key

If you want to create a new ssh key, follow this tutorial: https://www.ssh.com/academy/ssh/keygen
tldr; execute `ssh-keygen` in a terminal and follow the prompts. It's highly recommended that you add a passphrase to your key in case your keys get compromised.

NOTE: If you create a new ssh key, be sure to add it to the agent by executing `ssh-add ~/.ssh/my_new_ssh_key` from the terminal.

## Install sshpass

This script uses sshpass to pass each password non-interactively to the ssh agent.

https://linux.die.net/man/1/sshpass

For OSX, execute `brew install hudochenkov/sshpass/sshpass` from a terminal.

## Create the node password list

The node password list is a file that has a list of all IP addresses and passwords on which we want to copy the ssh key. Since you only need to do this once, it's probably wise to delete this once finished.

** Be sure to leave a blank line at the end of the file or the last entry won't get picked up **

```
1.2.3.4 pwFor1234
5.6.7.8 pwFor5678
...

```

## Execute the script

This will copy the ssh key to each node in the list.

`. copy-ssh-key.sh ~/.ssh/your_ssh_key /path/to/ip_password_list`

# execute-script.sh

This script executes another script on each node in the list.

** BE CAREFUL: make sure you know what commands you are executing on your VPS **

## Node list

The node list is a list of IP addresses to operate on.

** Be sure to leave a blank line at the end of the file or the last entry won't get picked up **

```
1.2.3.4
5.6.7.8
10.11.12.13
...

```

## Execute the script

`. execute-script.sh /path/to/machine_list /path/to/script "optional arguments for script"`

# execute-command.sh

This script executes a command on each node in the list.

** BE CAREFUL: make sure you know what commands you are executing on your VPS **

## Node list

The node list is a list of IP addresses to operate on.

** Be sure to leave a blank line at the end of the file or the last entry won't get picked up **

```
1.2.3.4
5.6.7.8
10.11.12.13
...

```

## Execute the script

`. execute-command.sh /path/to/machine_list "echo Hello World"`

# Example scripts

You can execute any script you want, but here are a few examples:

```bash
# Copy ssh keys to each node
. copy-ssh-key.sh ~/.ssh/presearch-cluster node-password-list.sample

# Install docker on each node
. execute-script.sh node_list install-docker.sh

# Start docker on each node
. execute-command.sh node_list "systemctl start docker"

# Enable docker service on each node
. execute-command.sh node_list "sudo systemctl enable /usr/lib/systemd/system/docker.service"

# Start PRE docker container
. execute-script.sh node_list start-presearch-docker-container.sh "myRegistrationCode"

# Reboot each node
. execute-command.sh node_list "shutdown -r now"
```
