#exclude typical bin bash at top line because Azure CLI gets confused and won't pass parameters if we do so.

MY_PUBLIC_IP=$1

# A script to install and running Folding@Home
# Modified slightly from original script by Samina Fu found at https://github.com/sufuf3/FAHClient-install
####################
# Configuring fahclient start
# include USER, TEAM, PASSKEY, POWER, AUTOSTART
####################
# Folding@home User Name (deault: Anonymous)
# eg. USER=myuser
USER=$2
# Folding@home Team Number(0 for no team)
# eg. TEAM=242029 = Centare
TEAM=242029
# Folding@home Passkey (option)
# eg. PASSKEY=12jkh#(13423rl##sdfsdfw
PASSKEY=$3
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

#Should FAHClient automatically discover GPUs?
GPU=true

####################
# Create the config.xml file
####################
sudo mkdir /tmp/fahclient
sudo cat >> /tmp/fahclient/config.xml <<EOF
<config>

  <!-- See sample config: /usr/share/doc/fahclient/sample-config.xml -->

  <!-- Client Control Don't fold anonymously, provide user info. -->
  <fold-anon v='false'/>

  <!-- Folding Slot Configuration -->
  <gpu v='$GPU'/>  <!-- If true, attempt to autoconfigure GPUs -->

  <!-- Slot Control
       Options: light, medium or full
       Watch out for high load -->
  <power v='full'/>

  <!-- User Information -->
  <user v='$USER'/>
  <passkey v='$PASSKEY'/>
  <team v='$TEAM'/>

  <!-- Folding Slots -->
  <!-- Use all the CPUs -->
  <slot id='0' type='CPU'>
     <cpus v='6'/>
  </slot>
  <slot id='1' type='GPU'/>

  <!-- Grant Remote Web Access access web UI from given IP -->
  <allow>$MY_PUBLIC_IP</allow>
  <web-allow>$MY_PUBLIC_IP</web-allow>

</config>
EOF

####################
# Configuring fahclient
####################
#install fah as a headless service
DEBIAN_FRONTEND=noninteractive sudo apt-get install -y debconf-utils
cd ~/
sudo wget https://download.foldingathome.org/releases/public/release/fahclient/debian-testing-64bit/v7.4/fahclient_7.4.4_amd64.deb
sudo wget https://download.foldingathome.org/releases/public/release/fahcontrol/debian-testing-64bit/v7.4/fahcontrol_7.4.4-1_all.deb
echo "fahclient fahclient/autostart boolean $AUTOSTART" | sudo debconf-set-selections
echo "fahclient fahclient/gpu boolean $GPU" | sudo debconf-set-selections
echo "fahclient fahclient/power select $POWER" | sudo debconf-set-selections
echo "fahclient fahclient/team string $TEAM" | sudo debconf-set-selections
echo "fahclient fahclient/passkey string $PASSKEY" | sudo debconf-set-selections
echo "fahclient fahclient/user string $USER" | sudo debconf-set-selections
sudo dpkg -i fahclient_7.4.4_amd64.deb
sudo dpkg -i --force-depends fahcontrol_7.4.4-1_all.deb

#cleanup
rm -f fahclient_7.4.4_amd64.deb

#reconfigure fahclient
sudo /etc/init.d/FAHClient stop
sudo mv /tmp/fahclient/config.xml /etc/fahclient/config.xml
sudo chown fahclient:root /etc/fahclient/config.xml
sudo /etc/init.d/FAHClient start
