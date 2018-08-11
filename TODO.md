# TODO List

30-07-2018
> to fix broken apt system
```
/etc/apt/apt.conf.d/
/etc/apt/sources.list.d/
/etc/apt/sources.list
```

## Tasks to be done for refining FDD setup script

- [ ] Add-Install VirtualBox
- [ ] Show hidden files in caja
- [ ] Add extensions in vscode
	- [ ] GitLens — Git supercharged
	- [ ] Markdown All in One
	- [ ] Markdown Extended
	- [ ] HTML CSS Support
	- [ ] IntelliSense for CSS class names in HTML
	- [ ] JS & CSS Minifier
- [ ] Use `tar --strip-components=1` option to install directly in install-folders
	- [ ] Comment call to `ClearFolder`
	- [ ] Add call to `makeOwnFolder`
- [ ] Pluma - Set timestamp format
	- [ ] `%Y-%b-%d %T`
- [ ] Chrome - add erail extension
- [ ] Get fqdn from `$(dirname $0)` and use in setup-fdd.sh:11
- [ ] Add GO Tools installation also to script
	- [ ] refer env setup notes and update
- [ ] Include VP-UML settings file, for copy
	- [ ] `${HOME}/.config/VisualParadigm/ws/.vpprefdata/.vp.preference`
- [ ] Update clear-sys to reflect current environment
- [ ] Update Working/contents-files.txt with current content
	- [ ] Very low priority, make script instead of manual update eachtime.
- [ ] task placeholder

## Done - aka Changelog
### 2018 Aug 11
- [x] Move SETUP_ROOT_LOCN to setup-fdd.sh from fdd-data.sh


### 2018 Jul 30

> All changes before this date, to align with changelog format

- [x] Atom - Set timestamp format
	- [x] `ddd, DD-MMM-YYYY HH:mm:ss.SSS ZZ`
- [x] update PlatformVars.sh in installed copy
- [x] Atom - update to current release version
- [x] VS Code - update to current release version
- [x] Add Robo3T commands
	- [x] in /10-Base/bin (start-robo3t)
	- [x] Shortcut, in 'Programming'
- [x] Fix linking error in go-path-virt
	- [x] rm; ln; goimports;
	- [x] `rm -vfr /10-Base/go-path-virt`
	- [x] uodate /etc/enironment to fix path
- [x] pandoc instructions in 30-Ext
	- [x] Add
	- [x] Verify
- [ ] Add Mongo DB command support
	- [x] Command `up-mongo` in /10-Base/bin
	- [ ] ~~change default port to custom port~~
- [x] VS Code settings - review and update
	- [x] Workspace settings
	- [x] User Settings
	- [X] GO launch profile
- [x] add `nbd` support to PlatformVars.sh
- [x] Disable MySQL auto start
- [x] Add alias to clean up VMUML work files
- [x] Add shortcuts for databases
	- [x] code-go
	- [x] down-mongo
	- [x] down-mysql
	- [x] up-mongo
	- [x] up-mysql
	- [x] stat-mysql
- [x] Add Shortcut for Robo3T
- [x] Cleanup `20-Resources/Copy/ShortCuts/icons/`
