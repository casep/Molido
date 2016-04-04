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
sudo dnf install /home/casep/Utils/RPMs/i386/skype-4.3.0.37-fedora.i586.rpm
sudo dnf install /home/casep/Utils/RPMs/x86_64/google-talkplugin_current_x86_64.rpm /home/casep/Utils/RPMs/x86_64/rpmfusion-free-release-23.noarch.rpm /home/casep/Utils/RPMs/x86_64/rpmfusion-nonfree-release-23.noarch.rpm /home/casep/Utils/RPMs/x86_64/google-chrome-stable_current_x86_64.rpm /home/casep/Utils/RPMs/x86_64/adobe-release-x86_64-1.0-1.noarch.rpm
sudo rpm --import /home/casep/Utils/RPMs/x86_64/linux_signing_key.pub
sudo dnf install totem rhythmbox lm_sensors wine.i686 nemo-dropbox evolution evolution-ews google-chrome-unstable google-chrome-stable gummi geany numpy remmina keepassx thinkfan git gcc gcc-c++ stress remmina-plugins-rdp remmina-plugins-vnc python2-matplotlib pwgen gstreamer1-libav gstreamer1-plugins-good gstreamer1-plugins-ugly gstreamer1-plugins-bad-free gstreamer-ffmpeg gstreamer-plugins-good gstreamer-plugins-ugly gstreamer-plugins-bad gstreamer-plugins-bad-free gstreamer-plugins-bad-nonfree dnf-automatic texmaker texlive-vmargin texlive-subfigure texlive-babel texlive-babel-english texlive-babel-spanish texlive-ulem autofs flash-plugin hunspell-es hunspell-en-GB aspell-en aspell-es VirtualBox kernel-devel
sudo dnf remove thunderbird pidgin hexchat parole yumex yumex-dnf

# Enable autofs
sudo echo "Documentation    -fstype=cifs,rw,noperm,credentials=/home/casep/.ssh/credentials_cifs    ://172.24.0.31/Hosted_Services" > /etc/auto.cifs
sudo sed -i '1i/home/casep/Hosted_Services     /etc/auto.cifs    --timeout=600 --ghost' /etc/auto.master

# My hosts
sudo rm -rf /etc/host ; sudo ln -s /home/casep/.ssh/hosts /etc/hosts

#VirtualBox thingies
sudo akmods; sudo systemctl restart systemd-modules-load.service
exit 0
