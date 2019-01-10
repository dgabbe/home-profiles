#!/usr/bin/env python3

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
repo = os.path.dirname(os.path.abspath(__file__))

scripts = [
    [".bash_aliases", "dot-bash_aliases"],
    [".bash_logout", "dot-bash_logout"],
    [".bash_profile", "dot-bash_profile"],
    [".bashrc", "dot-bashrc"],
    [".git-completion", "git-completion.bash"],
    [".profile", "dot-profile"]
]

# Append machine-user specific file if found
my_machine = str.split(platform.uname()[1], ".local")[0] \
             + "_" + getpass.getuser() + "_profile"
if os.path.isfile(os.path.join(repo, my_machine)):
    scripts.append([str("." + my_machine), my_machine])

for s in scripts:
    f = os.path.join(home, s[0])

    if os.path.isfile(f) and not os.path.islink(f):
        os.rename(f, f + ".org")
        print("\n    Moved", f, 'to', f, '.org')

    if os.path.islink(f):
        print('\n    ', f, "is a sym link. No changes to make.")
    else:
        os.symlink(os.path.join(repo, s[1]), f)
        print("\n    ", f, "->", os.path.realpath(f))
