sudo xbps-install -u xbps
sudo xbps-install -Suv
sudo xbps-install wget udevil -y
wget https://github.com/johna23-lab/cde-for-linux-void/releases/download/2.5.0a/cde-2.5.0a_3.x86_64.xbps
xbps-rindex -a cde-2.5.0a_3.x86_64.xbps
sudo xbps-install -R $PWD cde-2.5.0a_3

sudo -- sh -c "echo 127.0.0.1  "$(hostname )" >> /etc/hosts"
sudo -- sh -c "sudo echo ""$(ip addr show dev $(ip r | grep -oP 'default.*dev \K\S*') | grep -oP '(?<=inet )[^/]*(?=/)') $(hostname )"" >> /etc/hosts"

sudo rm -rf /var/dt/appconfig/appmanager/$USER-$USER-0
sudo mkdir -p /var/dt/appconfig/appmanager/$USER-$USER-0
find /var/dt/appconfig/appmanager/ -depth -not -path "/var/dt/appconfig/appmanager/$USER-$USER-0" |sed '$ d' | while read line; do sudo ln -s "$line" "/var/dt/appconfig/appmanager/$USER-$USER-0" ; done


echo "export TERM=xterm-256color" >>~/.bashrc
cp /usr/dt/config/sys.dtprofile $HOME/.dtprofile

#sed -i '/export dtstart/aconvert /usr/dt/backdrops/Sunset.jpg -resize 50% -colors 512 /usr/dt/backdrops/Sunset.pm' .dtprofile
sed -i '/export dtstart/asetxkbmap es' .dtprofile
sed -i '/export dtstart/aconvert /usr/dt/backdrops/Sunset.jpg -resize 40% -colors 512 $HOME/.dt/backdrops/Sunset.pm' .dtprofile
sed -i '/export dtstart/a#autorandr --load workstation1' .dtprofile
sed -i '/export dtstart/aautorandr --save workstation1' .dtprofile
sed -i '/export dtstart/axrandr --output $scr --mode 1024x768' .dtprofile
sed -i '/export dtstart/ascr="$(DISPLAY=:0 xrandr | grep primary | awk '"'{ print \$\1 }'"')"' .dtprofile

echo 'devmon --info-on-mount --sync --exec-on-drive "/usr/dt/bin/dtfile -folder %d" --exec-on-video "vlc --verbose=-1 dvd://%f" --exec-on-audio "vlc --verbose=-1 cdda://%f" & ' >$HOME/.dt/sessions/sessionetc

echo killall devmon >$HOME/.dt/sessions/sessionexit

chmod +x $HOME/.dt/sessions/sessione*

echo include >$HOME/.dt/dtwmrc 
echo  { >>$HOME/.dt/dtwmrc 
echo   /usr/dt/config/C/sys.dtwmrc >>$HOME/.dt/dtwmrc 
echo  } >>$HOME/.dt/dtwmrc 
echo Keys DtKeyBindings >>$HOME/.dt/dtwmrc 
echo { >>$HOME/.dt/dtwmrc 
echo 'Alt<Key>u root|icon|window|ifkey  f.exec "devmon --unmount-removable"' >>$HOME/.dt/dtwmrc 
echo } >>$HOME/.dt/dtwmrc 


sudo ln -s /etc/sv/lxdm /var/service/
sudo ln -s /etc/sv/rpcbind /var/service
sudo ln -s /etc/sv/statd /var/service
sudo ln -s /etc/sv/netmount /var/service
