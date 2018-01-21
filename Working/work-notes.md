## JAVA environments

## Add to README
**Download Links**
| App          | Download URL                                                                                |   Size |
| ------------ | ------------------------------------------------------------------------------------------- | ------:|
| GO Lang      | https://golang.org/dl/                                                                      |  99 MB |
| .NET SDK     | https://www.microsoft.com/net/download/linux                                                | 144 MB |
| nodejs       | https://nodejs.org/en/download/current/                                                     |  11 MB |
|              |                                                                                             |        |
| VS Code      | https://code.visualstudio.com/docs/?dv=linux64                                              |  64 MB |
| atom         | https://github.com/atom/atom/releases                                                       | 125 MB |
| GitEye       | https://www.collab.net/downloads/giteye#show-Linux                                          | 106 MB |
| ProjectLibre | https://sourceforge.net/projects/projectlibre/files/ProjectLibre/                           |  15 MB |
| VPUML        | https://www.visual-paradigm.com/download/community.jsp?platform=linux&arch=64bit&install=no | 429 MB |
|              |                                                                                             |        |
| mongodb      | https://www.mongodb.com/download-center#community                                           |  95 MB |
| robo3t       | https://robomongo.org/download                                                              |  35 MB |
|              |                                                                                             |        |

**VS Code extensions**
ext install ms-vscode.csharp
ext install lukehoban.go
ext install jsynowiec.vscode-insertdatestring
ext install chrmarti.regex
ext install shd101wyy.markdown-preview-enhanced
ext install darkriszty.markdown-table-prettify
ext install AlanWalk.markdown-toc

ext install PeterJausovec.vscode-docker
ext install joelday.docthis
ext install dbaeumer.vscode-eslint


## Create folder structure

pushd ${SETUP_ROOT_LOCN};

mkdir -vp 10-Apps/
mkdir -vp 10-Apps/10-Base/
mkdir -vp 10-Apps/10-Base/drivers/
mkdir -vp 10-Apps/20-DEV/
mkdir -vp 10-Apps/30-EXT/
mkdir -vp 20-Resources/
mkdir -vp 20-Resources/Copy/
mkdir -vp 20-Resources/Copy/ShortCuts/
mkdir -vp 20-Resources/Copy/ShortCuts/icons/
mkdir -vp 20-Resources/Copy/bin/
mkdir -vp 20-Resources/Install/
mkdir -vp 20-Resources/Install/Sans-OTF/
mkdir -vp 20-Resources/Install/Sans-TTF/
mkdir -vp 20-Resources/Install/Serif-OTF/
mkdir -vp 20-Resources/Install/Serif-TTF/
mkdir -vp 20-Resources/Install/fonts-zekr/
mkdir -vp 20-Resources/T-OneUse/
mkdir -vp 20-Resources/certs/

popd

## GO
is this needed?
`export GOBIN="$GOPATH/bin"`

see https://golang.org/doc/install#install
`golang.org/x/tools`

### Tools
- Option 1:
	- `go get -u golang.org/x/tools/...`
- Option 2
	- manually clone the git repo
	```sh
	cd $GOPATH/src/golang.org/x/tools;
	git clone https://github.com/golang/tools.git ...
	```

### Chromium
`sudo apt-get install chromium-browser`


## node updates
`npm -g --depth 9999 update`

```
