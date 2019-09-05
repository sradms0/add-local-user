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

# Create the user.
useradd -c "${COMMENT}" -m "${USERNAME}"

# Set the password for the user
echo "${USERNAME}:${PASSWORD}" | chpasswd

# Inform the user if the account was not able to be created for some reason. 
if [[ "${?}" -ne 0 ]]
then
    echo 'Unable to create this account'
    exit 1
fi

# Displays the username, password, and host where the account was created. 
