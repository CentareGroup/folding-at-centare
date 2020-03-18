#!/bin/sh
# A script to install and running Folding@Home
# Modified slightly from original script by Samina Fu found at https://github.com/sufuf3/FAHClient-install
DIR=~/
####################
# Configuring fahclient start
# include USER, TEAM, PASSKEY, POWER, AUTOSTART
####################
# Folding@home User Name (deault: Anonymous)
# eg. USER=myuser
USER=Anonymous
# Folding@home Team Number(0 for no team)
# eg. TEAM=242029 = Centare
TEAM=242029
# Folding@home Passkey (option)
# eg. PASSKEY=12jkh#(13423rl##sdfsdfw
PASSKEY=
##################
# light      - Recommended for laptops.                                   │
# medium     - Higher performance setting recommended for most desktops.  │
# full       - Contribute as much as possible.
# How much of your system resources should be used initially?
##################
# eg. POWER=medium
POWER=full
#Should FAHClient be automatically started? true or false
# eg. AUTOSTART=true
AUTOSTART=true
####################
# Configuring fahclient end
####################
sudo apt-get install -y debconf-utils
cd $DIR
sudo wget https://download.foldingathome.org/releases/public/release/fahclient/debian-testing-64bit/v7.4/fahclient_7.4.4_amd64.deb
sudo wget https://download.foldingathome.org/releases/public/release/fahcontrol/debian-testing-64bit/v7.4/fahcontrol_7.4.4-1_all.deb
echo "fahclient fahclient/autostart boolean $AUTOSTART" | sudo debconf-set-selections
echo "fahclient fahclient/power select $POWER" | sudo debconf-set-selections
echo "fahclient fahclient/team string $TEAM" | sudo debconf-set-selections
echo "fahclient fahclient/passkey string $PASSKEY" | sudo debconf-set-selections
echo "fahclient fahclient/user string $USER" | sudo debconf-set-selections
sudo dpkg -i fahclient_7.4.4_amd64.deb
sudo dpkg -i --force-depends fahcontrol_7.4.4-1_all.deb
rm -f fahclient_7.4.4_amd64.deb