#!/usr/bin/env bash
# -*- coding: utf-8 -*-
#
#  fedoraPostInstall.sh
#  
#  Copyright 2016 Carlos "casep" Sepulveda <casep@fedoraproject.org>
#  
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#  
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.
#  
#  


### Post install

# Lovely packages
rpm --import /home/casep/Utils/RPMs/x86_64/linux_signing_key.pub
dnf -y copr enable spot/chromium
dnf -y install /home/casep/Utils/RPMs/i386/skype-4.3.0.37-fedora.i586.rpm /home/casep/Utils/RPMs/x86_64/google-talkplugin_current_x86_64.rpm /home/casep/Utils/RPMs/x86_64/rpmfusion-free-release-23.noarch.rpm /home/casep/Utils/RPMs/x86_64/rpmfusion-nonfree-release-23.noarch.rpm /home/casep/Utils/RPMs/x86_64/google-chrome-stable_current_x86_64.rpm /home/casep/Utils/RPMs/x86_64/adobe-release-x86_64-1.0-1.noarch.rpm /home/casep/Utils/RPMs/i386/projectlibre-1.6.2-1.rpm
dnf -y remove thunderbird pidgin hexchat parole yumex yumex-dnf google-chrome-stable
dnf -y update
dnf -y install totem rhythmbox lm_sensors wine.i686 nemo-dropbox evolution evolution-ews google-chrome-unstable gummi geany numpy remmina keepassx thinkfan git gcc gcc-c++ stress remmina-plugins-rdp remmina-plugins-vnc python2-matplotlib pwgen gstreamer1-libav gstreamer1-plugins-good gstreamer1-plugins-ugly gstreamer1-plugins-bad-free gstreamer-ffmpeg gstreamer-plugins-good gstreamer-plugins-ugly gstreamer-plugins-bad gstreamer-plugins-bad-free gstreamer-plugins-bad-nonfree dnf-automatic texmaker texlive-vmargin texlive-subfigure texlive-babel texlive-babel-english texlive-babel-spanish texlive-ulem autofs flash-plugin hunspell-es hunspell-en-GB aspell-en aspell-es VirtualBox kernel-devel hplip chromium filezilla unrar mplayer strace nmap dia


# Enable autofs
echo "UKHosted	-fstype=cifs,rw,noperm,credentials=/home/casep/.ssh/credentials_cifs    ://172.24.0.31/Hosted_Services" > /etc/auto.cifs
echo "SMS		-fstype=cifs,rw,noperm,credentials=/home/casep/.ssh/credentials_cifs    ://172.24.32.11/shared" >> /etc/auto.cifs
sed -i '1i/home/casep/Hosted_Services     /etc/auto.cifs    --timeout=600 --ghost' /etc/auto.master

# Enable automatic dnf
perl -pi -e 's/apply_updates = no/apply_updates = yes/' /etc/dnf/automatic.conf 

#SELINUX
sudo perl -pi -e 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config

# My hosts
rm -rf /etc/hosts ; ln -s /home/casep/.ssh/hosts /etc/hosts

#VirtualBox thingies, this will probably fail due to kernel version
akmods; systemctl restart systemd-modules-load.service

#Frak passwords!
echo "casep	ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers

dnf upgrade -y

#Enable autofs
systemctl enable autofs


exit 0
