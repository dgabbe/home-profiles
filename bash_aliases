#-*-shell-script-*-

# Mac OSX specific
#
alias aquamacs='open -a /Applications/Aquamacs.app'
alias excel='open -a /Applications/Microsoft\ Office\ 2011/Microsoft\ Excel.app '
alias sourcetree='open -a /Applications/SourceTree.app'

# These should work with any *nix
#
alias ack='ack --ignore-dir=coverage'
alias dss='diff --side-by-side'
alias git-update='git fetch --tags; git fetch origin; for i in rc master; do git co $i; git pull origin $i; done'
alias knife-ssh='knife ssh '\''role:rails3 AND chef_environment:production AND NOT role:maintenance'\'' -a name -c config/chef/knife-prod.rb'
alias mac2unix='perl -pe '\''s/\r/\n/mg'\'''
alias marked='open -a /Applications/Marked.app'
alias path='ruby -e "puts ENV[\"PATH\"].gsub(/:/, \"\n\")"'
alias pretty_json='ruby -r json -e '\''txt = File.read(ARGV[0]); h = JSON.parse(txt); puts JSON.pretty_generate(h)'\'''
alias psgrep='ps aux | grep -v grep | grep '
alias tabify='ruby -pe '\''gsub(/ +/, "\t")'\'''
alias ll='ls -al'
