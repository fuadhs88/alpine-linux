#!/bin/ash

apk add curl socat nmap net-tools build-base setxkbmap sudo xrandr bash zsh dbus dbus-x11 sudo setup-xorg-base xfce4 xfce4-terminal lightdm dbus-x11
apk add open-vm-tools open-vm-tools-guestinfo open-vm-tools-deploypkg open-vm-tools-gtk
apk add lightdm-gtk-greeter i3wm i3status libxcb-dev i3lock xf86-video-vmware dmenu
apk add mesa-gl glib feh firefox-esr accountsservice openvpn
apk add docker docker-compose

# add user
adduser igg
mkdir -p /home/igg/wallpaper
mkdir -p /home/igg/.config/i3

# user setup igg
cp ./igg/wallpaper/compass.jpg /home/igg/wallpaper/compass.jpg
cp ./igg/.config/i3/config /home/igg/.config/i3/config
cp ./igg/.profile /home/igg/.profile
mkdir -p /home/igg/.scripts
cp ./igg/login-script.sh /home/igg/.scripts/login-script.sh
chown -R igg:igg /home/igg

# add igg to sudoers
cat ./igg/sudoers >> /etc/sudoers

# greeter background
echo "background=/home/igg/wallpaper/compass.jpg" >> /etc/lightdm/lightdm-gtk-greeter.conf

# set background image in accountsservice
cp ./igg/igg /var/lib/AccountsService/users
chown root:root /var/lib/AccountsService/users/igg

# add user to docker
addgroup igg docker

# enable copy paste in vmware
chmod g+s /usr/bin/vmware-user-suid-wrapper

# give igg write access to /opt dir
chown igg:igg /opt

# mkdir /opt/docker
mkdir -p /opt/docker
cp ./docker/* /opt/docker/
chown igg:igg /opt/docker


