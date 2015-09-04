#!/usr/bin/env bash
# Mac OSX specific
# Written to be Bash 3.x compatible
mac_apps=("Aquamacs" "BBedit" "RStudio" "SourceTree")
for a in "${mac_apps[@]}"
do
	al=$(echo "$a" | tr [:upper:] [:lower:])
	if [[ -e "/Applications/${a}.app" ]]; then alias ${al}="open -a /Applications/${a}.app"; fi
done

# These should work with any *nix. Uncomment the ones you want
alias chex='chmod -vv u+x '
alias dss='diff --side-by-side'
#alias path='ruby -e "puts ENV[\"PATH\"].gsub(/:/, \"\n\")"'
#alias pretty_json='ruby -r json -e '\''txt = File.read(ARGV[0]); h = JSON.parse(txt); puts JSON.pretty_generate(h)'\'''
#alias tabify='ruby -pe '\''gsub(/ +/, "\t")'\'''
