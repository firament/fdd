# fdd
Automation scripts to bring a raw ubuntu installation to a known state

## Before Running

1. In setup-fdd.sh, Line 8
	- Change `plain_text_password` to 'Actual password'

2. scaffold working directories
	- Do before starting downloads
```sh
mkdir -vp 10-Apps/10-Base/drivers;
mkdir -vp 10-Apps/20-DEV;
mkdir -vp 10-Apps/30-EXT;
mkdir -vp 10-Apps/40-APPIMAGES;
mkdir -vp 20-Resources/Copy/bin/;
mkdir -vp 20-Resources/Copy/ShortCuts/;
mkdir -vp 20-Resources/Install/;
mkdir -vp 20-Resources/Install/Mono-TTF;
mkdir -vp 20-Resources/Install/Sans-TTF;
mkdir -vp 20-Resources/Install/Serif-TTF;
```
---

## Quick Download Links
- Updated on: 2026-02-22

| Loc     | App          | Curr Ver    | Download URL                                                                                |   Size |
| ------- | ------------ | ----------- | ------------------------------------------------------------------------------------------- | ------:|
| Install | Git Cred Mgr | 2.8.0       | https://github.com/git-ecosystem/git-credential-manager/                                    |  29 MB |
| Install | Chrome       | 138.0.7204  | https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb                   | 115 MB |
| Install | Opera        | 127.0.5778  | https://download.opera.com/download/get/?partner=www&opsys=Linux                            | 126 MB |
| Install | Docker       | 29.2.1-1    | docs/docker-ubuntu.md                                                                       |  92 MB |
|         |              |             |                                                                                             |        |
| 10-Base | Chromium     | 1629464     | Working/Apps-to-add.md#Chromium                                                             | 217 MB |
| 10-Base | .NET SDK     | 8.0.421     | https://www.microsoft.com/net/download/linux                                                | 207 MB |
| 10-Base | .NET SDK     | 10.0.300    | https://www.microsoft.com/net/download/linux                                                | 229 MB |
| 10-Base | Java SDK     | 26.0.1      | https://jdk.java.net/                                                                       | 212 MB |
| 10-Base | node.js      | 24.15.0     | https://nodejs.org/en/download/                                                             |  30 MB |
|         |              |             |                                                                                             |        |
| 20-DEV  | VS Code      | 1.119.x     | https://code.visualstudio.com/docs/?dv=linux64                                              | 160 MB |
| 20-DEV  | VS Codium    | 1.116.02821 | https://github.com/VSCodium/vscodium/releases                                               | 155 MB |
| 20-DEV  | VPUML        | 18_0_260502 | https://www.visual-paradigm.com/download/community.jsp?platform=linux&arch=64bit&install=no | 788 MB |
| 20-DEV  | DBeaver      | 26.0.4      | https://dbeaver.io/download/                                                                | 119 MB |
| 20-DEV  | SQLeoVQB+    | 19.01rc1    | https://sourceforge.net/projects/sqleo/files/SQLeoVQB/                                      |   3 MB |
| 20-DEV  | CudaText     | 1.234.3.0   | https://sourceforge.net/projects/cudatext/files/release/                                    |   7 MB |
| 20-DEV  | Textadept    | 12.9        | https://orbitalquark.github.io/textadept/                                                   |  10 MB |
|         |              |             |                                                                                             |        |
| 30-EXT  | Lite XL      | 2.1.8       | https://github.com/lite-xl/lite-xl/releases                                                 |   3 MB |
| 30-EXT  | ecode+       | 0.8.0       | https://github.com/SpartanJ/ecode/releases                                                  |  28 MB |
| 30-EXT  | Pulsar+      | 1.131.3     | https://github.com/pulsar-edit/pulsar/releases/                                             | 240 MB |
| 30-EXT  | Lapce        | v0.4.6      | https://github.com/lapce/lapce/releases/                                                    |  23 MB |
| 30-EXT  | FileZilla+   | 3.70.5      | https://filezilla-project.org/download.php?show_all=1                                       |  12 MB |
| 30-EXT  | SnowFlake+   | 1.0.4       | https://github.com/subhra74/snowflake/releases                                              |  39 MB |
| 30-EXT  | ProjectLibre | 1.9.8       | https://sourceforge.net/projects/projectlibre/files/ProjectLibre/                           |  21 MB |
|         |              |             |                                                                                             |        |
| 40-APP  | CherryTree   | 1.6.3       | https://github.com/giuspen/cherrytree/releases                                              | 100 MB |
| 40-APP  | Cursor       | 3.3.30      | https://cursor.com/download                                                                 | 274 MB |
| 40-APP  | sourcegit+   | 2026.10     | https://github.com/sourcegit-scm/sourcegit/releases                                         |  24 MB |
| 40-APP  | FreeCAD+     | 1.1.1       | https://www.freecad.org/downloads.php?lang=en                                               | 760 MB |
| 40-APP  | KiCad+       | 10.0.2      | https://www.kicad.org/download/linux/                                                       | 290 MB |
| 40-APP  | Inkscape     | 1.4.4       | https://inkscape.org/release/                                                               | 124 MB |
| 40-APP  | Theia IDE+   | 1.63        | https://theia-ide.org/#theiaidedownload                                                     | 382 MB |
|         |              |             |                                                                                             |        |
| drivers | PgSQL driver | 42.7.11     | https://jdbc.postgresql.org/download/                                                       |   1 MB |
| drivers | MySql driver | 9.7.0       | https://dev.mysql.com/downloads/connector/j/                                                |   5 MB |
| drivers | MSSql driver | 13.4.0      | https://docs.microsoft.com/en-us/sql/connect/jdbc/microsoft-jdbc-driver-for-sql-server      |  12 MB |
|         |              |             |                                                                                             |        |


### Notes
- Not used on all machines, exclude unless needed
	- [SQLeoVQB](https://sourceforge.net/projects/sqleo/files/SQLeoVQB/)
	- [ecode](https://github.com/SpartanJ/ecode/releases)
	- [Pulsar](https://github.com/pulsar-edit/pulsar/releases/)
	- [FileZilla](https://filezilla-project.org/download.php?show_all=1)
	- [SnowFlake](https://github.com/subhra74/snowflake/releases)
	- [SourceGit](https://github.com/sourcegit-scm/sourcegit/releases/)
	- [Theia IDE](https://theia-ide.org/#theiaidedownload)
	- [FreeCAD](https://www.freecad.org/downloads.php?lang=en)
	- [KiCad](https://www.kicad.org/download/linux/)

### Other:
- https://jdk.java.net/archive/
- Fonts
	- https://github.com/microsoft/cascadia-code/releases/
	- https://github.com/tonsky/FiraCode/releases/
	- https://fonts.google.com/specimen/Carlito
	- https://fonts.google.com/specimen/Caladea
- Browsers
	- https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	- https://www.opera.com/download#opera-browsers
	- Chromium [see](Working/Apps-to-add.md)
---

