#!/bin/bash

# Enforce exectution with superuser (root) privileges.
if [[ "${UID}" -ne 0 ]]
then 
    echo "Root privileges are required" 
    exit 1
fi

echo '*** Create a new user ****'

# Prompt for username to create.
read -p 'Enter username: ' USERNAME

# Prompt for the name for person who will be using the account.
read -p 'Enter account holder name: ' COMMENT

# Prompt for the initial password for the account.
read -p 'Enter password: ' PASSWORD

# Create a new user on the local system with the input provided by the user.
useradd -c "${COMMENT}" -m "${USERNAME}"

# Informs the user if the account was not able to be created for some reason. 

# If the account is not created, the script is to return an exit status of 1.

# Displays the username, password, and host where the account was created. 
