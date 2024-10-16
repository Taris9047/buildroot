#!/bin/sh


# Downloading prereq pachages...
sudo apt-get update && sudo apt-get install -y debianutils sed make binutils build-essential gcc g++ bash patch gzip bzip2 perl tar cpio unzip rsync file bc git

# downloading external st definitions files...
git clone https://github.com/bootlin/buildroot-external-st.git ../buildroot-external-st

# Initialize the config with default settings..
make BR2_EXTERNAL=../buildroot-external-st st_stm32mp157d_dk1_defconfig

# Now run make menuconfig and make...
printf 'Now you can run make menuconfig... or just make...\n'
