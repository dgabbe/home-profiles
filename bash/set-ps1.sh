#! /usr/bin/env bash
#
# Set the PS1 & PS2 prompts.  Assume xterm compatibility.
#
# Terminals and terminal emulators are funny things. Fancy prompts require knowing
# the terminal's escape codes and number of colors it supports.  Have't seen a
# non-xterm emulator for so long the code doesn't test for it.  The number of colors
# an xterm supports is compiled when the distro is built. The definitive answer is
# stored in the terminal database.
#
# Suggest sticking to colors 0 - 15 which are Xterm system colors.
#
# The old test for color was:
# case "$TERM" in
#  xterm-*color | xterm | rxvt*)
#
# References:
#   - https://makandracards.com/makandra/1090-customize-your-bash-prompt
#   - https://www.askapache.com/linux/bash-power-prompt/#Prompt_Escape_Codes
#   - https://jonasjacek.github.io/colors/
#   - https://wiki.archlinux.org/index.php/Bash/Prompt_customization#List_of_colors_for_prompt_and_Bash
#   - https://unix.stackexchange.com/questions/269077/tput-setaf-color-table-how-to-determine-color-codes
#   - https://invisible-island.net/ncurses/ncurses.faq.html#xterm_256color
#

export GIT_PS1_SHOWDIRTYSTATE=1

if [ -f ${HOME}/.git_completion ]; then
    source ${HOME}/.git_completion
fi

_normal_txt=0
_bold_txt=1
_blue=4
_window_title="\[\e]0;\u@\h: \w\a\]"
_user="\[\e[${_normal_txt};3${_blue}m\]\u\[\e[0m\]"
_host="\[\e[${_normal_txt};3${_blue}m\]\h\[\e[0m\]"
_shell_level="[$SHLVL]"
_wd="\[\e[${_bold_txt};3${_blue}m\]\w\[\e[0m\]"
_eop="\n\$ "


case `tput colors` in
  16)
      ;&
  256)
    export PS1=''${_window_title}''${_user}'@'${_host}''${_shell_level}': '${_wd}' $(__git_ps1 "(%s)")'${_eop}''
    export PS2='\[\e[0;3${_blue}m\]> '
    ;;
  *)
    export PS1=''${_window_title}'\u@\h'${_shell_level}': \w $(__git_ps1 "(%s)")'${_eop}''
    ;;
esac

unset _normal_txt
unset _bold_txt
unset _blue
unset _window_title
unset _user
unset _host
unset _shell_level
unset _wd
unset _eop
