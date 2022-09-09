sudo useradd -m $(jq -r '.inputs.username' $GITHUB_EVENT_PATH)
sudo adduser $(jq -r '.inputs.username' $GITHUB_EVENT_PATH) sudo
echo $(jq -r '.inputs.username' $GITHUB_EVENT_PATH):$(jq -r '.inputs.password' $GITHUB_EVENT_PATH) | sudo chpasswd
sudo sed -i 's/\/bin\/sh/\/bin\/bash/g' /etc/passwd
sudo hostname $(jq -r '.inputs.computername' $GITHUB_EVENT_PATH)
# Setup Ubuntu Desktop
sudo apt update
sudo apt install ubuntu-desktop
sudo apt-get install xbase-clients python3-psutil xvfb -y
wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
sudo dpkg --install chrome-remote-desktop_current_amd64.deb
sudo apt install --assume-yes --fix-broken
sudo adduser $(jq -r '.inputs.username' $GITHUB_EVENT_PATH) chrome-remote-desktop
echo -e "$(jq -r '.inputs.password' $GITHUB_EVENT_PATH)" | su - $(jq -r '.inputs.username' $GITHUB_EVENT_PATH) -c """$(jq -r '.inputs.authcode' $GITHUB_EVENT_PATH) --pin=$(jq -r '.inputs.pincode' $GITHUB_EVENT_PATH)"""
# Setup Ngrok
wget -q https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-386.zip
unzip ngrok-stable-linux-386.zip
chmod +x ./ngrok
echo -e "$(jq -r '.inputs.password' $GITHUB_EVENT_PATH)\n$(jq -r '.inputs.password' $GITHUB_EVENT_PATH)" | sudo passwd "$USER"
rm -f .ngrok.log
./ngrok authtoken $(jq -r '.inputs.authtoken' $GITHUB_EVENT_PATH)
./ngrok tcp 22 --log ".ngrok.log" &
sleep 10
