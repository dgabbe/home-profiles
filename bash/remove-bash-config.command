#!/usr/bin/env python

# Set up your account to have the various bash config files point to your local git repo.
#
# Assume script is run from git local working directory.
#
# Repo file names are with the leading "."
#
# Any links found will be removed, regardless of how the link was created.
#

from __future__ import print_function
import getpass
from json import load
from os import environ, rename, symlink, path, remove
from os.path import dirname, isfile, islink, abspath, join
from socket import gethostname
from sys import exit

home = environ["HOME"]
repo = dirname(abspath(__file__))

install_files = abspath("install-files.json")
if isfile(install_files):
    try:
        file = open(install_files, "r")
        scripts = load(file)
    except FileNotFoundError as e:
        print("  {} was not found. Cannot proceed :-(".format(e.name))
        exit(1)
    finally:
        file.close()

# Append host-user specific file if found
my_profile = str.split(gethostname(), ".")[0] + "_" + getpass.getuser() + "_profile"
if isfile(join(repo, str(my_profile + ".sh"))):
    scripts.append([str("." + my_profile), str(my_profile + ".sh")])

for s in scripts:
    f = join(home, s[0])
    if islink(f):
        remove(f)
        print("\n    ", f, "removed.")
