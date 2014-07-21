# http://stackoverflow.com/questions/23399183/bash-command-prompt-with-virtualenv-and-git-branch

ps1_git()
{
  local branch="" sha1="" line="" attr="" color=0

  shopt -s extglob # Important, for our nice matchers :)

  command -v git >/dev/null 2>&1 || {
    printf " \033[1;37m\033[41m[git not found]\033[m "
    return 0
  }

  branch=$(git symbolic-ref -q HEAD 2>/dev/null) || return 0 # Not in git repo.
  branch=${branch##refs/heads/}

  # Now we display the branch.
  sha1=$(git rev-parse --short --quiet HEAD)

  case "${branch:-"(no branch)"}" in
   production|prod) attr="1;37m\033[" ; color=41 ;; # red
   master|deploy)   color=31                     ;; # red
   stage|staging)   color=33                     ;; # yellow
   dev|develop|development) color=34             ;; # blue
   next)            color=36                     ;; # gray
   *)
     if [[ -n "${branch}" ]] ; then # Feature Branch :)
       color=32 # green
     else
       color=0 # reset
     fi
     ;;
  esac

  [[ $color -gt 0 ]] &&
    printf "\[\033[${attr}${color}m\](git:${branch}$(ps1_git_status):$sha1)\[\033[0m\] "
}

ps1_git_status()
{
  local git_status="$(git status 2>/dev/null)"

  [[ "${git_status}" = *deleted* ]]                    && printf "%s" "-"
  [[ "${git_status}" = *Untracked[[:space:]]files:* ]] && printf "%s" "+"
  [[ "${git_status}" = *modified:* ]]                  && printf "%s" "*"
}

ps1_identity()
{
  if (( $UID == 0 )) ; then
    printf "%s" "\[\033[31m\]\\u\[\033[0m\]@\[\033[36m\]\\h\[\033[35m\]:\w\[\033[0m\] "
  else
    printf "%s" "\[\033[32m\]\\u\[\033[0m\]@\[\033[36m\]\\h\[\033[35m\]:\w\[\033[0m\] "
  fi
}

ps1_titlebar()
{
  case $TERM in
    (xterm*|rxvt*)
      printf "%s" "\033]0;\\u@\\h: \W\\007"
      ;;
  esac
}

# bash_prompt
# The various escape codes that we can use to color our prompt.
        RED="\[\033[0;31m\]"
     YELLOW="\[\033[1;33m\]"
      GREEN="\[\033[0;32m\]"
       BLUE="\[\033[1;34m\]"
  LIGHT_RED="\[\033[1;31m\]"
LIGHT_GREEN="\[\033[1;32m\]"
      WHITE="\[\033[1;37m\]"
 LIGHT_GRAY="\[\033[0;37m\]"
 COLOR_NONE="\[\e[0m\]"

 # Return the prompt symbol to use, colorized based on the return value of the
 # previous command.
 function set_prompt_symbol () {
   if test $1 -eq 0 ; then
       PROMPT_SYMBOL="\$"
   else
       PROMPT_SYMBOL="${LIGHT_RED}\$${COLOR_NONE}"
   fi
 }

 # Determine active Python virtualenv details.
 function set_virtualenv () {
   if test -z "$VIRTUAL_ENV" ; then
       PYTHON_VIRTUALENV=""
   else
       PYTHON_VIRTUALENV="${BLUE}[`basename \"$VIRTUAL_ENV\"`]${COLOR_NONE} "
   fi
 }

 # Set the full bash prompt.
 function set_bash_prompt () {
   # Set the PROMPT_SYMBOL variable. We do this first so we don't lose the
   # return value of the last command.
   set_prompt_symbol $?

   # Set the PYTHON_VIRTUALENV variable.
   set_virtualenv

   VERSION=$(python -V 2>&1)

   # Set the bash prompt variable.
   PS1="$(ps1_titlebar)\D{%H:%M:%S} $(ps1_identity)$(ps1_git)${VERSION} ${PYTHON_VIRTUALENV}\n\$ "
 }

 # Tell bash to execute this function just before displaying its prompt.
 PROMPT_COMMAND=set_bash_prompt
