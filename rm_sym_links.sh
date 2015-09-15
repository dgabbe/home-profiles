#!/usr/bin/env bash

sdir=$(cd `dirname "${BASH_SOURCE[0]}"` && pwd -P)

scripts=("bash_aliases" "bash_logout" "bash_profile" "bashrc" "profile")

# Append machine specific file if found
my_machine=${HOSTNAME%.local}_profile
if [ -e "${my_machine}" ]; then
	scripts+=(${my_machine})
fi

for s in "${scripts[@]}"
do
	f=$HOME/.${s}
	if [[ -L ${f} ]]
	then
		rm -v ${f}
	fi
done

