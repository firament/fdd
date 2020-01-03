# TODO List

## Tasks to be done for refining FDD setup script

- [ ] x
- [ ] Try MonoDevelop (7.6.9.22)
	```sh
	sudo apt install apt-transport-https dirmngr
	sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
	echo "deb https://download.mono-project.com/repo/ubuntu vs-bionic main" | sudo tee /etc/apt/sources.list.d/mono-official-vs.list
	sudo apt update
	sudo apt-get install monodevelop
	```
- [ ] Add local cache to `~/.nuget/NuGet/NuGet.Config`
	- [ ] `/media/sak/70_Current/Downloads/NuGetFallbackFolder`
- [ ] Add Pinguybuilder install function
	- [ ] include all dependencies
	- [ ] install deb directly
- [ ] Clean up x-* binaries
- [ ] Review VSCode settings
	- Multi Cursor Modifier (Why does alt works on some?)
	- editor.autoClosingBrackets
	- editor.autoClosingQuotes
	- html.format.wrapAttributes
- [ ] Move `/10-Base/DNC/sdk/NuGetFallbackFolder` to a container
	- 1+ GB on disk
	- [ ] Add `~/Documents/containers.md` with commands to mount common containers
- [ ] Clean up GO configuration, WS copy
- [ ] Add GO Tools installation also to script
	- [ ] refer env setup notes and update
- [ ] Include VP-UML settings file, for copy
	- [ ] `${HOME}/.config/VisualParadigm/ws/.vpprefdata/.vp.preference`
- [ ] Update clear-sys to reflect current environment
- [ ] Update Working/contents-files.txt with current content
	- [ ] Very low priority, make script instead of manual update each time.
- [ ] task placeholder

## Done - aka Changelog
### 2018 Sep 22
- [x] Clean ~/Documents folder manually
	- [x] all except 'setup-fdd-logs'
- [ ] Update Extensions (0903)
	- [x] Atom
	- [x] VSCode
	- [x] DNC
- [x] Update VSCode default settings
- [x] Clean up script, with test updates

### 2018 Aug 28
- [x] Fix libre office menus to sides, to optimize wide-screen usage
- [x] Set 'Eye of MATE Image Viewer' as default images for png and jpeg files
- [x] VSCode
	- [x] Update extensions
	- [x] Add sidebar toggle in `${HOME}/.config/Code/User/keybindings.json`

### 2018 Aug 23
- [x] Use `tar --strip-components=1` option to install directly in install-folders
	- [x] Comment call to `ClearFolder`
	- [x] Add call to `makeOwnFolder`
- [x] Add manual install for pinguybuilder - fix

### 2018 Aug 11
- [x] Get fqdn from `$(dirname $0)` and use in setup-fdd.sh:11
	- `$(realpath $(dirname $0))`
- [x] Add-Install VirtualBox
- [x] Show hidden files in caja
- [x] Add extensions in vscode
	- [x] GitLens — Git supercharged
	- [x] Markdown All in One
	- [x] Markdown Extended
	- [x] HTML CSS Support
	- [ ] ~~IntelliSense for CSS class names in HTML~~
	- [x] JS & CSS Minifier
- [x] Pluma - Set timestamp format
	- [x] `%Y-%b-%d %T`
- [x] Chrome - add erail extension
- [x] ~~Move SETUP_ROOT_LOCN to setup-fdd.sh from fdd-data.sh~~
- [x] Remove directory from robo3t shortcut, to stop showing up in 'Open With'


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
