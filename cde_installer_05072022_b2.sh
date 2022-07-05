sudo xbps-install -Su
wget https://github.com/johna23-lab/cde-for-linux-void/releases/download/2.4.0_5/cde-2.4.0_5.x86_64.xbps
xbps-rindex -a cde-2.4.0_5.x86_64.xbps
sudo xbps-install -R $PWD cde-2.4.0_5

sudo -- sh -c "echo 127.0.0.1  "$(hostname )" >> /etc/hosts"
sudo -- sh -c "sudo echo ""$(ip addr show dev $(ip r | grep -oP 'default.*dev \K\S*') | grep -oP '(?<=inet )[^/]*(?=/)') $(hostname )"" >> /etc/hosts"

sudo rm -rf /var/dt/appconfig/appmanager/$USER-$USER-0
sudo mkdir -p /var/dt/appconfig/appmanager/$USER-$USER-0
find /var/dt/appconfig/appmanager/ -depth -not -path "/var/dt/appconfig/appmanager/$USER-$USER-0" |sed '$ d' | while read line; do sudo ln -s "$line" "/var/dt/appconfig/appmanager/$USER-$USER-0" ; done


echo "export TERM=xterm-256color" >>~/.bashrc
cp /usr/dt/config/sys.dtprofile $HOME/.dtprofile


sed -i '/export dtstart/asetxkbmap es' .dtprofile
sed -i '/export dtstart/axrandr --output $scr --mode 1024x768' .dtprofile
sed -i '/export dtstart/ascr="$(DISPLAY=:0 xrandr | grep primary | awk '"'{ print \$\1 }'"')"' .dtprofile

sudo ln -s /etc/sv/lxdm /var/service/
sudo ln -s /etc/sv/rpcbind /var/service
sudo ln -s /etc/sv/statd /var/service
sudo ln -s /etc/sv/netmount /var/service
