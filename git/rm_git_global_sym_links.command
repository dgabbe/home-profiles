#! /usr/bin/env python

#
# Remove git config files in your home directory
#
# Assume script is run from git local working directory.
#
# Repo file names are without the leading "."
#
# Assume if a link is found, the environment is already setup, but not
# necessarily by this repo.
#

import os
import platform
import string
import sys

home = os.environ["HOME"]
repo = os.path.dirname(os.path.abspath(sys.argv[0])) # Very simple, may need to revisit

scripts = ["gitconfig", "gitignore_global", "stCommitMsg"]

# Append machine specific file if found
my_machine = string.split(platform.uname()[1], ".local")[0] + "_profile"
if os.path.exists(my_machine):
	scripts.append(my_machine)

for s in scripts:
	f = os.path.join(home, "." + s)
	if os.path.islink(f):
		os.remove(f)
		print "\n    ", f, " removed."
