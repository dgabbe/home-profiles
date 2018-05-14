#! /usr/bin/env python

#
# Set up git config files in your home directory
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
repo = os.path.dirname(os.path.abspath(__file__))

scripts = ["gitconfig", "gitignore_global", "stCommitMsg"]

for s in scripts:
	f = os.path.join(home, "." + s)

	if os.path.isfile(f) and not os.path.islink(f):
		os.rename(f, f + ".org")
		print "\n    Moved ", f, "to ", f, ".org"

	if os.path.islink(f):
		print "\n    ", f, "is a sym link. No changes to make."
	else:
		os.symlink(os.path.join(repo, s), f)
		print "\n    ", f, " -> ", os.path.realpath(f)

