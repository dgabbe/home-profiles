#!/usr/bin/env bash
#
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
#

#
# If not running interactively, don't do anything
#
[ -z "$PS1" ] && return

#
# set PATH so it includes user's private bin if it exists
#
if [ -d "${HOME}/bin" ]
then
    PATH="${HOME}/bin:${PATH}"
fi

#
# Set CDPATH & machine specific environment variables and aliases if present.
#
my_machine=${HOME}/.${HOSTNAME%.local}_${USER}_profile
if [ -e "${my_machine}" ]
then
  source ${my_machine}
fi
unset my_machine

#
# Set options using set or shopt or export listed alphabetically
#

shopt -s cdspell
# Update the values of LINES and COLUMNS after each command
shopt -s checkwinsize # Update the values of LINES and COLUMNS after each command

# if [[${BASH_VERSINFO} = "5"]]
# then
#   shopt -s dirspell
# fi

set -o emacs
shopt -s histappend # Append to the history file, don't overwrite it
export HISTCONTROL='ignoredups:ignorespace' # don't put duplicate lines in the history.
export HISTFILESIZE=2000
shopt -s histreedit # If you bork a ! in bash, this lets you edit the line.
export HISTSIZE=1000
# opt out Homebrew analytics
export HOMEBREW_NO_ANALYTICS=1
#
# Required to make MacTex compatible w/older versions of Ruby.
# Deprecated in newer versions of Ruby and no longer a problem.
#
export LANGUAGE='en_US:en'
export LC_MESSAGES='en_US.UTF-8'
export LC_CTYPE='en_US.UTF-8'
export LC_COLLATE='en_US.UTF-8'

shopt -s nocaseglob # Case-insensitive wildcard matching.
export PYTHONDONTWRITEBYTECODE=1 # No .pyc files
## !! There is bash_completion 2 for bash 4+ which should be added here ##
## Also look at Ned's https://github.com/nedbat/dot/blob/master/.bashrc, line 252
## if [[ $BASH_VERSINFO -ge 4 ]]; then ##
# bash-completion bug - https://github.com/scop/bash-completion/issues/44
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  set +o nounset
  source $(brew --prefix)/etc/bash_completion
else
  set -o nounset
fi

#
# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
#
if [ -f ${HOME}/.bash_aliases ]; then
    source ${HOME}/.bash_aliases
fi

#
# Set prompt, window title, git status
#
if [ -f ${HOME}/.set-ps1 ]; then
    source ${HOME}/.set-ps1
fi

#
# load rvm
#
if [ -s "${HOME}/.rvm/scripts/rvm" ]; then
  PATH=${PATH}:${HOME}/.rvm/bin # Add RVM to PATH for scripting
  source "${HOME}/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
  # load git prompt
  if [[ $- == *i* ]]
  then
    . ${HOME}/.rvm/contrib/ps1_functions
    ps1_set --prompt \$
  fi
fi

#
# Stuff from Bosco's file, but not supported on OS X
#
# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"