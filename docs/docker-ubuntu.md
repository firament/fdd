# Docker engine on Ubuntu
> 2024-05-05
> https://docs.docker.com/engine/install/ubuntu/
> Install from a package

## Prepare
- download the deb files for your release and install manually
- To upgrade, download the newer package files and repeat the installation procedure, pointing to the new files.
- https://download.docker.com/linux/ubuntu/dists/
	- select Ubuntu version in the list
	- go to `pool/stable/`
	- select architecture (amd64, armhf, arm64, or s390x)
	- download deb files for the Docker Engine, CLI, containerd, and Docker Compose packages:
		- containerd.io_<version>_<arch>.deb
		- docker-ce_<version>_<arch>.deb
		- docker-ce-cli_<version>_<arch>.deb
		- docker-buildx-plugin_<version>_<arch>.deb
		- docker-compose-plugin_<version>_<arch>.deb

***
## Install
	- Install the .deb packages. Update the paths in the following example to where you downloaded the Docker packages.
	```sh
	sudo dpkg -i \
		./containerd.io_<version>_<arch>.deb \
		./docker-ce_<version>_<arch>.deb \
		./docker-ce-cli_<version>_<arch>.deb \
		./docker-buildx-plugin_<version>_<arch>.deb \
		./docker-compose-plugin_<version>_<arch>.deb
	```
	- actuals
	```sh
sudo dpkg -i \
    containerd.io_1.6.31-1_amd64.deb \
    docker-ce_26.1.1-1~ubuntu.22.04~jammy_amd64.deb \
    docker-ce-cli_26.1.1-1~ubuntu.22.04~jammy_amd64.deb \
    docker-buildx-plugin_0.14.0-1~ubuntu.22.04~jammy_amd64.deb \
    docker-compose-plugin_2.27.0-1~ubuntu.22.04~jammy_amd64.deb \
    ;

    # addl, not documented
    docker-ce-rootless-extras_26.1.1-1~ubuntu.22.04~jammy_amd64.deb \
    docker-scan-plugin_0.23.0~ubuntu-jammy_amd64.deb \
	
	```

***
## Verify
	```sh
	docker --version
	```

***
## Refine - sudo-less
> https://docs.docker.com/engine/install/linux-postinstall/
- Apply
	```sh
	sudo groupadd docker
	sudo usermod -aG docker $USER
	```
- Cleanup (repair sudo effects)
	```sh
	sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
	sudo chmod g+rwx "$HOME/.docker" -R
	```
- auto start (enable/disable)
	```sh
	sudo systemctl disable docker.service
	sudo systemctl disable containerd.service
	```
***

## Working notes
- https://download.docker.com/linux/ubuntu/dists/jammy/pool/stable/amd64/
- automate
	```
	wget [OPTION]... [URL]...
	-B,  --base=URL                  resolves HTML input-file links (-i -F) relative to URL
	-S,  --server-response           print server response
	-P,  --directory-prefix=PREFIX   save files to PREFIX/..
	```
