#!/bin/sh

#
# System initialization script for current build...
#
# This is a reference script, not for actual use..
#

#
# Wifi initialization
#
# Set WiFi PW
wpa_passpharase "<<SSID>>" "<<RouterPW>>" >> /etc/wpa_supplicant.conf
# Run WiFi Connection
wpa_supplicant -B -D nl80211 -i wlan0 -c /etc/wpa_supplicant.conf

#
# Time change
#
echo "TZ=UTC+4" >> "/etc/profile" # or +5 if summer time ends...

#
# Setting up NTPD
#
# Make sure you have selected ntp and ntpd at menuconfig
#
# Referenced
# https://wiki.luckfox.com/Luckfox-Pico/Luckfox-Pico-ntpd/
#
killall -9 ntpd
ntpd -p ca.ntp.org -gn
hwclock --systohc
hwclock -u -s

#
# Add me as a user... and sudoer
#

# As a root...
# 1. make user
#
mkdir -p /home/taris
adduser taris
chown -R taris:taris /home/taris
chmod -R 2775 /home/taris

#
# 2. sudo
#
# At /etc/sudoers
#
# Uncomment
# %wheel ALL=(ALL:ALL) ALL
#
# Also at /etc/group
# add 'taris' to...
# sudo:xxx:
# wheel:xxx:
# lines...
#

#
# 3. Some basic bashrc
#
# Add lines below
#
# alias ls='ls --color'
# alias ll='ls -alh --color'
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'
#
# Also remember to make .profile to put these lines
#
# if [ -n "$BASH_VERSION" ]; then
#   if [ -f "${HOME}/.bashrc" ]; then
#     . "${HOME}/.bashrc"
#   fi
# fi


#
# 4. Resize the main partition to use entire SD Card space
#
# run parted.
# You will find the last paritition, most likely to be 6,
# be capable of expanding.
#
# Run resizepart <<the 6th partition>> << your SDCard size >>
# then quit
#
# then run
# resize2fs <<that 6th parition>>
#
# then you're done!

#
# 5. Some bash prompt decoration
#
# Add below to /etc/profile
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
    . $script
  fi
done

unset script RED GREEN NORMAL



