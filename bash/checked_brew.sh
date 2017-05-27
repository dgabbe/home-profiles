#! /usr/bin/env bash

set -o nounset # deal w/bash-completion bug
trap "set +o nounset" SIGINT SIGTERM EXIT RETURN

#
# Prevent various file protection problems and other stupidities.
#
# If you work from a non-admin account and 'sudo - admin-account', the
# umask in effect is from the non-admin account. If umask is set to
# 0022, '-g:rwx' and '-o:rx', things won't run and fixing this problem
# requires uninstalling homebrew.  Discovered June 2016.
#
# On OS X, accounts by default are created w/out any.rc files. It's
# reasonable to keep create an additional admin account that is modified
# to support privileged dev related work.
#

# fiddling around for brew function.
# move aliases from bashrc to bash_aliases!

# Remember to move elsewhere like under Groups
export HOMEBREW_CACHE=/Volumes/Mini-HD2/Users2/gadmin/Homebrew/Caches/

error_prefix="  ${0##*/} error: "
admin_group='admin'
default_umask=0022
read_commands_regex='(cask info|cat|config|home|list|search|)'

if [[ $(shopt extglob) == 'extglob on' ]]; then
  echo "$error_prefix requires option extglob to be 'on'"
  exit 1
fi

if [[ ! "$*" =~ ${read_commands_regex} || $# -eq 0 ]]; then
  command brew $*
  exit $?
fi

#
# dscl is OS X specific
#
groups=$(dscl . read /Groups/${admin_group} GroupMembership)
if ! [[ ${groups} =~ \<${USER}\> ]]; then
  echo "$error_prefix $USER is not an admin"
  exit 1
fi

if [ $(umask) -ne $default_umask ]; then
  echo "$error_prefix umask not set to $default_umask"
  exit 1
fi

#
# Execute brew command from admin account
#
command brew $*

trap - SIGINT SIGTERM EXIT RETURN
