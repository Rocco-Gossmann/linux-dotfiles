#!/usr/bin/bash

sudo cp ./kmonad.service /etc/systemd/system/
sudo chmod +x /etc/systemd/system/kmonad.service
sudo systemctl daemon-reload
sudo systemctl enable kmonad.service

echo "install kmonad binary to /opt/kmonad/kmonad"
echo "copy your desired keyfile to /opt/kmonad/keys.kbd"
echo "then run sudo systemctl start kmonad.service"