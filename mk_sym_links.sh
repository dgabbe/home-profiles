#!/usr/bin/env bash

sdir=$(dirname ${BASH_SOURCE})
scripts=("bash_aliases" "bash_logout" "bash_profile" "bashrc"  "dgabbeMini_profile" "profile")
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

