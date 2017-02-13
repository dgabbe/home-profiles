#! /usr/bin/env bash

# fiddling around for brew function.
# figure out local nounset!
## figure out local variable declarations - functions only!
# move aliases from bashrc to bash_aliases!  Check in MacMini changes first!!

error_prefix="  ${0##*/} error: "
admin_group='admin'
default_umask=0022
read_commands_regex='.*[search|list|home|cat|cask info].*'
args=$(echo ${*} | grep -e $read_commands_regex)
echo "  args: $args"
echo "  length of params: ${#args}"
echo "  length of match: ${args#?(search|list|home|cat|cask info)}"

# this command worked: echo 'cask list' | grep '.*[search|list].*'

# below - change to check for string of zero length
if [[ -n $(echo ${*} | grep -e ${read_commands_regex}) ]];  then
  echo "inside test match"
fi
echo "after test match"

exit

if ! [[ "$*" =~ ${read_commands_regex} ]]; then
echo "inside read commands"
echo "args: $*"
  command brew $*
  exit $?
fi

#
# dscl is OS X specific
#
groups=$(dscl . read /Groups/${admin_group} GroupMembership)
if ! [[ ${groups} =~ ".*\<${USER}\>.*" ]]; then
  echo "$error_prefix $USER is not an admin"
  exit 1
fi

if [ $(umask) -ne $default_umask ]; then
  echo "$error_prefix umask not set to $default_umask"
  exit 1
fi

command brew $*

# alias brew=checked_brew() # add to system specific file
