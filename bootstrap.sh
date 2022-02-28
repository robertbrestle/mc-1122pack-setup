#!/bin/bash
sudo yum update -y
sudo yum install java-1.8.0-openjdk-devel -y

PACK=1.4.0

# create and install server
mkdir /root/$PACK
wget https://solder.endermedia.com/repository/downloads/the-1122-pack/the-1122-pack_$PACK.zip -O /root/$PACK/the-1122-pack_$PACK.zip
unzip /root/$PACK/the-1122-pack_$PACK.zip -d /root/$PACK
chmod +x /root/$PACK/LaunchServer.sh

# agree to EULA
echo "eula=true" > /root/$PACK/eula.txt

# set single block for spawn protection
echo -e "\nspawn-protection=-1" >> /root/$PACK/server.properties

# create minecraft.service for easy auto-start
echo -e "[Unit]\nDescription=Minecraft Server\nAfter=network-online.target\nWants=network-online.target\n\n[Service]\nType=oneshot\nWorkingDirectory=/root/$PACK\nExecStart=/root/$PACK/LaunchServer.sh\n\n[Install]\nWantedBy=multi-user.target\n\n# cp minecraft.service /etc/systemd/system/minecraft.service\n# sudo systemctl daemon-reload\n#sudo systemctl enable minecraft.service\n" > minecraft.service
# install the service
cp minecraft.service /etc/systemd/system/minecraft.service
sudo systemctl daemon-reload
sudo systemctl enable minecraft.service
