# TODO List

## Tasks to be done for refining FDD setup script

### v3.0 tasks
> 2020-11-15 21:56:59
- [ ] Link iteratively all bins
	- [ ] /10-Base/node/bin
	- [ ] mongo - remove dir from path
	- [ ] mongosh
	- [ ] 
- [ ] Android Studio
	- [x] Add setup
	- [ ] Add offline build deps
	- https://developer.android.com/studio#downloads
		- a3f278a8162aa65f103bf51f8e664cf5179de0047c93111e2f86251d44d9dbc3 offline-android-gradle-plugin-preview.zip 
		- f632eed0d7c2e540665242d7e44156efff1e10ddf878cffa4de312958f2c0e2f offline-gmaven-stable.zip
	- https://developer.android.com/studio/intro/studio-config#offline
- [x] Fix ruby bundles, investigate script
- [x] Identify markdown extensions used earlier
- [ ] Update scripts for addl apps
	- [x] Postman
	- [x] FileZilla
	- [x] Eclipse
		- Update ln in script, for project scripts
	- [x] Netbeans
	- [ ] Docker
- [ ] Read release notes for dnc 5.0
	- https://github.com/dotnet/core/blob/master/release-notes/5.0/5.0.0/5.0.0.md
    - [ ] [dotnet/sdk:](https://hub.docker.com/_/microsoft-dotnet-sdk/)
    - [ ] [dotnet/aspnet:](https://hub.docker.com/_/microsoft-dotnet-aspnet/)
    - [ ] [dotnet/runtime:](https://hub.docker.com/_/microsoft-dotnet-runtime/)
    - [ ] [dotnet/runtime-deps](https://hub.docker.com/_/microsoft-dotnet-runtime-deps/)
    - [ ] [dotnet/samples:](https://hub.docker.com/_/microsoft-dotnet-samples/)
- [x] Configure markdown environment
	- https://marketplace.visualstudio.com/items?itemName=jebbs.markdown-extended
		- markdown-it-container
		



### v2.x tasks
- [x] Add Ruby install code
	- [x] Add ruby path to PATH
- [x] Clean up font files
- [ ] update favourites list
- [x] drop aliases, hardly ever used.
- [x] include mysql setup, as seperate function
- [x] exclude ${RBENV_ROOT} and ${RBENV_STUB} from image script
- [x] do up-dnc
- [x] do up-ruby
- [ ] in up-ruby add
	- link /10-Base/rbenv-root/bin/rbenv to /10-Base/rbenv-root/libexec/rbenv
- [x] Add Atom configuration file in setup script
- [x] Add plug marker file from setup script
- [x] Verify mongo path
- [x] Disable mysql auto start
- [ ] Add rbenv gits update function


## Older tasks (v1.x)
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
- [x] Clean up x-* binaries
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

***

## Pleiades bright stars
| Name              | Distance (ly)[45] | Apparent magnitude | Pronunciation (IPA) | Designation     | Stellar classification |
| ----------------- | ----------------- | ------------------ | ------------------- | --------------- | ---------------------- |
| —                 | 444.30            | 5.66               | —                   | 18 Tauri        | B8V                    |
| Sterope, Asterope | 431.10            | 5.64;6.41          | /(ə)ˈstɛrəpiː/      | 21 and 22 Tauri | B8Ve/B9V               |
| Celaeno           | 434±10            | 5.44               | /sɪˈliːnoʊ/         | 16 Tauri        | B7IV                   |
| Pleione           | 422±11            | 5.09 (var.)        | /ˈpliːəniː, ˈplaɪ-/ | 28 (BU) Tauri   | B8IVpe                 |
| Taygeta           | 364±16            | 4.29               | /teɪˈɪdʒɪtə/        | 19 Tauri        | B6V                    |
| Merope            | 344±16            | 4.17               | /ˈmɛrəpiː/          | 23 Tauri        | B6IVev                 |
| Maia              | 344±25            | 3.86               | /ˈmeɪ.ə/            | 20 Tauri        | B7III                  |
| Electra           | 375±23            | 3.70               | /ɪˈlɛktrə/          | 17 Tauri        | B6IIIe                 |
| Atlas             | 387±26            | 3.62               | /ˈætləs/            | 27 Tauri        | B8III                  |
| Alcyone           | 409±50            | 2.86               | /ælˈsaɪ.əniː/       | Eta (25) Tauri  | B7IIIe                 |


| Name     | Dst | Mag–Min | Mag-Max | Mag-Scale | X | Y | Z |
| -------- | --- | ------- | ------- | --------- | - | - | - |
| Merope   | 344 | 4.17    | 4.17    |           |   |   | x |
| Maia     | 344 | 3.86    | 3.86    |           |   |   | x |
| Taygeta  | 364 | 4.29    | 4.29    |           |   |   | x |
| Electra  | 375 | 3.7     | 3.7     |           |   |   | x |
| Atlas    | 387 | 3.62    | 3.62    |           |   |   | x |
| Alcyone  | 409 | 2.86    | 2.86    |           |   |   | x |
| Pleione  | 422 | 5.09    | 5.09    |           |   |   | x |
| Sterope  | 431 | 5.64    | 6.41    |           |   |   | x |
| Asterope | 431 | 5.64    | 6.41    |           |   |   |   |
| Celaeno  | 434 | 5.44    | 5.44    |           |   |   | x |

***
