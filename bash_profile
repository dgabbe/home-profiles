#-*-shell-script-*-

# .bash_profile is for making sure that both the things in .profile and .bashrc are loaded
# for login shells.

if [ -e ~/.profile ]
then
    source ~/.profile
fi

if [ -e ~/.bashrc ]
then
    source ~/.bashrc
fi

