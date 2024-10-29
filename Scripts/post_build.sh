#!/bin/sh

# Timezone setup
echo "TZ=UTC+4" >> "/etc/profile"

# NTPD setting
killall -9 ntpd
ntpd -p ca.ntp.org -gn
hwclock --systohc
hwclock -u -s

# Adding me
mkdir -p /home/taris
adduser taris
chown -R taris:taris /home/taris
chmod -R 2775 /home/taris
passwd -e taris

# Setting up some bash stuffs..
#
cat >/root/.profile <<EOF
alias ls='ls --color'
alias ll='ls -alh --color'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
if [ -n "$BASH_VERSION" ]; then
  if [ -f "${HOME}/.bashrc" ]; then
    . "${HOME}/.bashrc"
  fi
fi
EOF

cp /root/.profile /home/taris/.profile

# Basic Bash decoration
#
cat >/etc/profile <<EOF
NORMAL="\[\e[0m\]"
RED="\[\e[1;31m\]"
GREEN="\[\e[1;32m\]"
if [[ $EUID == 0 ]] ; then
  PS1="$RED\u [ $NORMAL\w$RED ]# $NORMAL"
else
  PS1="$GREEN\u [ $NORMAL\w$GREEN ]\$ $NORMAL"
fi

for script in /etc/profile.d/*.sh ; do
  if [ -r $script ] ; then
  │ . $script
  fi
done

unset script RED GREEN NORMAL
EOF

# Setting up sudoers to allow taris
#
cat >/etc/sudoers <<EOL
%wheel ALL=(ALL:ALL) ALL
EOL

# Find out how to add my name to /etc/group file...
