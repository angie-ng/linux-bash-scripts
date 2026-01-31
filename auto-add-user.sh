#!/bin/bash

# This script adds a new Linux user



# ------------------------------------------------------
# add new user from the first parameter of the command for running the script (např. ./add_user.sh jan.novak)
# ------------------------------------------------------

USERNAME=$1  # value of the first parameter saves in the variable USERNAME


# this part verifies if the script runs as root
if [ "$EUID" -ne 0 ]; then  # if $EUID (effective user ID) not equal 0, then... (-ne stands for not equal, root has id 0)
        echo "Please run this script as root."
        exit 1 # says there's an error (we didn't run the script as root) so quit the script and do not continue with other steps anymore
fi


# this part verifies if the username was written in the parameter
if [ -z "$USERNAME" ]; then  # if the string $USERNAME is empty (-z is an option which stands for zero-length string), then...
        echo "Write the username as a parameter of the script $0, please. Eg. $0 anna.novakova"  # $0 is the name of the script
        exit 1  # says there's an error (the username was not written into the parameter) so quit the script
fi


# this part verifies if the user already exists
if getent passwd "$USERNAME" > /dev/null; then  #asks system if there is the user as an  entry in the /etc/passwd, output is thrown out to /dev/null
        echo "Username $USERNAME already exists."
        exit 1
fi

useradd -m -s /bin/bash "$USERNAME"  # creates the user with the name saved in the variable, -m creates his home dir, -s sets up his shell
passwd "$USERNAME"  # sets user's password to the value saved in the variable


# Plans for the future:
# ------------------------------------------------
# sets random password to the user
# ------------------------------------------------


# ----------------------------------------------
# uloží toto heslo do souboru /root/users_credentials.txt,
# --------------------------------------------------

# --------------------------------------------------
#přidá ho do skupiny developers, pokud existuje — jinak ji vytvoří.
# -------------------------------------------------------
