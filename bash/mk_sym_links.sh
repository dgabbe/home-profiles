#!/usr/bin/env bash

sdir=$(cd `dirname "${BASH_SOURCE[0]}"` && pwd -P)

scripts=("bash_aliases" "bash_logout" "bash_profile" "bashrc" "profile" "Xdefaults")

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
		printf "\n    ${f} is a sym link. No change to make.\n"
		continue
	fi
	
	if [[ -f ${f} ]]
	then
		mv -v ${f} ${f}.org
	fi

	ln -vs ${sdir}/${s}  ${f}
done

