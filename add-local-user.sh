#!/bin/bash

# This script adds a local user to the system.

# Enforce exectution with superuser (root) privileges.
if [[ "${UID}" -ne 0 ]]
then 
    echo "Root privileges are required" >&2
    exit 1
fi

# Inform the user the correct argument length (2) was not provided.
if [[ "${#}" -lt 2 ]]
then
    echo "Usage: ${0} [USER_NAME] [ACCOUNT_HOLDER]" >&2
    exit 1
fi

# Store username and comment (account holder).
USERNAME="${1}"
shift
COMMENT="${@}"

# Generate a random password.
SYMBOLS='$%^&*()_-+=@'
SHUFFLED_SYMBOL=$( echo "${SYMBOLS}" | fold -w1 | shuf | head -c1)
SHUFFLED_DATE=$(echo $(date +%s%N | fold -w1 | shuf))
RANDOM_NUM=$(echo "${RANDOM}" | head -c1)
PASSWORD=$(echo "${RANDOM_NUM}${SHUFFLED_DATE}" | sha256sum | head -c10)"${SHUFFLED_SYMBOL}"

# Create the user.
useradd -c "${COMMENT}" -m "${USERNAME}" &> /dev/null

# Set the password for the user.
echo "${USERNAME}:${PASSWORD}" | chpasswd &> /dev/null

# Prompt user for new password upon first login
passwd -e "${USERNAME}" &> /dev/null

# Inform the user if the account was not able to be created for some reason. 
if [[ "${?}" -ne 0 ]]
then
    echo 'Unable to create this account' >&2
    exit 1
fi

## Display the username, password, and host where the account was created. 
echo "***User successfully created at $(hostname)***"
echo "username: ${USERNAME} password: ${PASSWORD}"
