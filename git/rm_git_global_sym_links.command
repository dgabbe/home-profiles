#! /usr/bin/env python

#
# Remove git config files in your home directory
#
# Assume script is run from git local working directory.
#
# Repo file names are without the leading "."
#

from __future__ import print_function
import os
import platform
import string
import sys

home = os.environ["HOME"]
repo = os.path.dirname(os.path.abspath(sys.argv[0])) # Simple, may need to revisit

scripts = ["gitconfig", "gitignore_global", "stCommitMsg"]

for s in scripts:
  f = os.path.join(home, "." + s)
  if os.path.islink(f):
    os.remove(f)
    print("\n    {} removed.".format(f)
