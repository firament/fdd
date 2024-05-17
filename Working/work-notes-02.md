> To be updated into readme

## scaffold working directories
```sh
mkdir -vp 10-Apps/10-Base/drivers;
mkdir -vp 10-Apps/20-DEV;
mkdir -vp 10-Apps/30-EXT;
mkdir -vp 20-Resources/Copy/bin/;
mkdir -vp 20-Resources/Copy/bin/;
mkdir -vp 20-Resources/Copy/ShortCuts/;
mkdir -vp 20-Resources/Install/;
mkdir -vp 20-Resources/Install/Mono-TTF;
mkdir -vp 20-Resources/Install/Sans-TTF;
mkdir -vp 20-Resources/Install/Serif-TTF;
```

## Updates
### Fix base path
```sh
echo;
echo "Install Docker engine";
sudo dpkg -i \
    ${RESOURCE_FOLDER}/Install/docker/containerd.io_1.6.9-1_amd64.deb \
    ${RESOURCE_FOLDER}/Install/docker/docker-ce_26.1.1-1~ubuntu.22.04~jammy_amd64.deb \
    ${RESOURCE_FOLDER}/Install/docker/docker-ce-cli_26.1.1-1~ubuntu.22.04~jammy_amd64.deb \
    ${RESOURCE_FOLDER}/Install/docker/docker-buildx-plugin_0.14.0-1~ubuntu.22.04~jammy_amd64.deb \
    ${RESOURCE_FOLDER}/Install/docker/docker-compose-plugin_2.27.0-1~ubuntu.22.04~jammy_amd64.deb \
    ;
```
