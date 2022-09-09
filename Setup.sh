sudo useradd -m $(jq -r '.inputs.username' $GITHUB_EVENT_PATH)
sudo adduser $(jq -r '.inputs.username' $GITHUB_EVENT_PATH) sudo
echo $(jq -r '.inputs.username' $GITHUB_EVENT_PATH):$(jq -r '.inputs.password' $GITHUB_EVENT_PATH) | sudo chpasswd
sudo sed -i 's/\/bin\/sh/\/bin\/bash/g' /etc/passwd
sudo apt-get update
wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
sudo dpkg --install chrome-remote-desktop_current_amd64.deb
sudo apt install --assume-yes --fix-broken
sudo DEBIAN_FRONTEND=noninteractive \
apt install --assume-yes xfce4 desktop-base
sudo bash -c 'echo "exec /etc/X11/Xsession /usr/bin/xfce4-session" > /etc/chrome-remote-desktop-session'  
sudo apt install --assume-yes xscreensaver
sudo systemctl disable lightdm.service
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg --install google-chrome-stable_current_amd64.deb
sudo apt install --assume-yes --fix-broken
sudo adduser $(jq -r '.inputs.username' $GITHUB_EVENT_PATH) chrome-remote-desktop
echo -e "$(jq -r '.inputs.password' $GITHUB_EVENT_PATH)" | su - $(jq -r '.inputs.username' $GITHUB_EVENT_PATH) -c """$(jq -r '.inputs.authcode' $GITHUB_EVENT_PATH) --pin=$(jq -r '.inputs.pin' $GITHUB_EVENT_PATH)"""










sudo hostname $(jq -r '.inputs.computername' $GITHUB_EVENT_PATH)
wget -q https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-386.zip
unzip ngrok-stable-linux-386.zip
chmod +x ./ngrok
echo -e "$(jq -r '.inputs.password' $GITHUB_EVENT_PATH)\n$(jq -r '.inputs.password' $GITHUB_EVENT_PATH)" | sudo passwd "$USER"
rm -f .ngrok.log
./ngrok authtoken $(jq -r '.inputs.authtoken' $GITHUB_EVENT_PATH)
./ngrok tcp 22 --log ".ngrok.log" &
sleep 10
