# The 1.12.2 Pack Minecraft Server Setup
Setup for a modded Minecraft server on an Amazon EC2 instance.

---

# Hardware Requirements
The official requirements for The 1.12.2 Pack indicate the recommended memory at 5-6GB. Through personal testing, I've found using 8GB of memory and allocating 6-7GB to the server gave the best results.

## AWS Sizes
- Basic server  
    - m5a.large (2x8)  
- Advanced server  
    - c5a.xlarge (4x8)  
    - m5a.xlarge (4x16)  

The above options typically run cheap at about $0.10/hr on-demand. If you plan on running a server 24/7, it is highly recommended to set up a [reserved instance](https://aws.amazon.com/ec2/pricing/reserved-instances/) to save on costs.

## Storage
For a single EC2 server, you should only need a 16GB root volume. This should provide adequate space the installation, saved world, and automated backups (~5GB).

## Network Security
To protect your server, it is recommended to set the following network security inbound rules:
- SSH
    - `TCP 22`: your home public IP address (remove after setup if possible)
- Steam/Game Ports
    - `TCP 25565`: `0.0.0.0/0`

---

# Setup Instructions
After deploying your new EC2 instance, follow the below instructions to configure the dedicated server.

1. As root, run `bootstrap.sh`  
    - this script is currently optimized for version `1.4.0`  
	- change the `$PACK` variable to the desired version  
2. Update `server.properties` as you see fit
3. Reboot the server to leverage the startup service  
    - the server creation/startup will take a few minutes  

## Upgrading
You can typically upgrade these servers in-place with the following configuration.  

1. As root, run `bootstrap.sh` with the updated `$PACK variable`  
2. Copy the following files from the old folder to the new folder:  
    - `eula.txt`  
	- `server.properties`  
	- `LaunchServer.sh`  
	- any other modified configuration files necessary  
3. Copy your `world/` directory to the new folder  
4. Update `minecraft.service` to point to the new folder  
    - `sudo cp minecraft.service /etc/systemd/system/minecraft.service`  
	- `sudo systemctl daemon-reload`  
5. Reboot the server to leverage the startup service  
    - the server creation/startup will take a few minutes  

---

# References
- [The 1.12.2 Pack on Technic](https://www.technicpack.net/modpack/the-1122-pack.1406454)  
- [The 1.12.2 Pack Server Downloads](https://the-1122-pack.com/repo)  

---

&nbsp;