# Ruby Install
> Using rbenv

## Commands
```sh
rbenv install -v 2.7.2  2>&1 | tee ${HOME}/Documents/setup-fdd-logs/ruby-install-$(date +"%Y%m%d-%s").log
# Installed ruby-2.7.2 to /home/fsap/.rbenv/versions/2.7.2
```

## Errors
- Log files
	- /tmp/ruby-build.20201023233006.15598.log
	- /tmp/ruby-build.20201023234040.30542.log
	- /tmp/ruby-build.20201023234940.47851.log
- post install
	- `~/.rbenv/shims` should be in path

## Fixes
```sh
sudo apt-get install libssl-dev
sudo apt-get install zlib1g-dev

export PATH="/home/fsap/bin:/home/fsap/.rbenv/shims;/10-Base/rbenv-root/bin:/10-Base/bin:/bin:/usr/sbin:/usr/bin:/sbin:/10-Base/DNC:/30-EXT/mongodb/bin:/10-Base/jre/bin:/10-Base/go/bin:/10-Base/go-tools/bin:/usr/local/sbin:/usr/local/bin:/snap/bin:/usr/games:/usr/local/games"
```
