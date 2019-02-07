#!/usr/bin/env python

# Set up your account to have the various bash config files point to your local git repo.
#
# Assume script is run from git local working directory.
#
# Repo file names are with the leading "."
#
# Assume if a link is found, the environment is already setup, but not
# necessarily by this repo.
#

import getpass
import os
import platform
import string
import sys

home = os.environ["HOME"]
repo = os.path.dirname(os.path.abspath(sys.argv[0])) # Very simple, may need to revisit

scripts = [
  [".bash_aliases", "dot-bash_aliases"],
  [".bash_logout", "dot-bash_logout"],
  [".bash_profile", "dot-bash_profile"],
  [".bashrc", "dot-bashrc"],
  [".git-completion", "git-completion.bash"],
  [".profile", "dot-profile"],
  [".set-ps1", "set-ps1.sh"]
]

# Append machine-user specific file if found
my_machine = str.split(platform.uname()[1], ".local")[0] \
  + "_" + getpass.getuser() + "_profile"
if os.path.isfile(os.path.join(repo, my_machine)):
  scripts.append([str("." + my_machine), my_machine])

for s in scripts:
  f = os.path.join(home, s[0])
  if os.path.islink(f):
    os.remove(f)
    print "\n    ", f, "removed."
