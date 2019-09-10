#!/bin/bash

# This script adds a local user to the system.

# Enforce exectution with superuser (root) privileges.
if [[ "${UID}" -ne 0 ]]
then 
    echo "Root privileges are required" 
    exit 1
fi

# Inform the user the correct argument length (2) was not provided.
if [[ "${#}" -ne 2 ]]
then
    echo "Usage: ${0} [USER_NAME] [ACCOUNT_HOLDER]"
    exit 1
fi

# Store username and comment (account holder).
USERNAME="${1}"
COMMENT="${2}"

# Generate a random password.
SYMBOLS='$%^&*()_-+=@'
SHUFFLED_SYMBOL=$( echo "${SYMBOLS}" | fold -w1 | shuf | head -c1 )
SHUFFLED_DATE=$( echo $(date +%s%N | fold -w1 | shuf) | tr -d ' ' | head -c5)
RANDOM_NUM=$(echo "${RANDOM}" | head -c1)
PASSWORD="${RANDOM_NUM}${SHUFFLED_SYMBOL}${SHUFFLED_DATE}"

# Create the user.
useradd -c "${COMMENT}" -m "${USERNAME}"

# Set the password for the user.
echo "${USERNAME}:${PASSWORD}" | chpasswd

# Inform the user if the account was not able to be created for some reason. 
if [[ "${?}" -ne 0 ]]
then
    echo 'Unable to create this account'
    exit 1
fi

## Display the username, password, and host where the account was created. 
echo "*** User successfully created at $(hostname)***"
echo "username: ${USERNAME} password: ${PASSWORD}"
