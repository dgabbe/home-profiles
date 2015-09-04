#!/usr/bin/env bash
# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
umask 066

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# Set machine specific environment variables and aliases if present. Useful for CDPATH
my_machine=$HOME/.${HOSTNAME%.local}_profile
if [ -e "${my_machine}" ]; then
	source ${my_machine}
fi

# Required to make MacTex compatible w/older versions of Ruby. 
# Deprecated in newer versions of Ruby and no longer a problem.
export LANGUAGE="en_US:en"
export LC_MESSAGES="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
