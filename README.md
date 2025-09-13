# fdd
Automation scripts to bring a raw ubuntu installation to a known state

---

## Before Running

1. In setup-fdd.sh, Line 8
	- Change `plain_text_password` to 'Actual password'

---

## Quick Download Links
- Updated on: 2025-07-19

| Loc     | App          | Curr Ver    | Download URL                                                                                |   Size |
| ------- | ------------ | ----------- | ------------------------------------------------------------------------------------------- | ------:|
| Install | Git Cred Mgr | 2.6.1       | https://github.com/git-ecosystem/git-credential-manager/                                    |  30 MB |
| Install | Chrome       | 138.0.7204  | https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb                   | 113 MB |
| Install | Opera        | 119.0.5497  | https://download.opera.com/download/get/?partner=www&opsys=Linux                            | 126 MB |
| Install | Docker       | 28.3.2-1    | docs/docker-ubuntu.md                                                                       |  92 MB |
|         |              |             |                                                                                             |        |
| 10-Base | Chromium     | 1463259     | Working/Apps-to-add.md#Chromium                                                             | 200 MB |
| 10-Base | .NET SDK     | 8.0.412     | https://www.microsoft.com/net/download/linux                                                | 207 MB |
| 10-Base | Java SDK     | 24.0.2      | https://jdk.java.net/                                                                       | 203 MB |
| 10-Base | node.js      | 24.4.1      | https://nodejs.org/en/download/                                                             |  31 MB |
|         |              |             |                                                                                             |        |
| 20-DEV  | VS Code      | 1.102.1     | https://code.visualstudio.com/docs/?dv=linux64                                              | 148 MB |
| 20-DEV  | VS Codium    | 1.102.14746 | https://github.com/VSCodium/vscodium/releases                                               | 144 MB |
| 20-DEV  | VPUML        | 17.2.250617 | https://www.visual-paradigm.com/download/community.jsp?platform=linux&arch=64bit&install=no | 765 MB |
| 20-DEV  | DBeaver      | 25.1.2      | https://dbeaver.io/download/                                                                |  86 MB |
| 20-DEV  | SQLeoVQB     | 19.01rc1    | https://sourceforge.net/projects/sqleo/files/SQLeoVQB/                                      |   3 MB |
| 20-DEV  | CudaText     | 1.226.0.0   | https://sourceforge.net/projects/cudatext/files/release/                                    |   7 MB |
| 20-DEV  | Textadept    | 12.7        | https://orbitalquark.github.io/textadept/                                                   |  10 MB |
|         |              |             |                                                                                             |        |
| 30-EXT  | Lite XL      | 2.1.8       | https://github.com/lite-xl/lite-xl/releases                                                 |   3 MB |
| 30-EXT  | ecode        | 0.7.1       | https://github.com/SpartanJ/ecode/releases                                                  |  25 MB |
| 30-EXT  | Pulsar+      | 1.128.0     | https://github.com/pulsar-edit/pulsar/releases/                                             | 215 MB |
| 30-EXT  | FileZilla+   | 3.69.2      | https://filezilla-project.org/download.php?show_all=1                                       |  12 MB |
| 30-EXT  | SnowFlake+   | 1.0.4       | https://github.com/subhra74/snowflake/releases                                              |  39 MB |
|         |              |             |                                                                                             |        |
| 40-APP  | CherryTree   | 1.5.0       | https://github.com/giuspen/cherrytree/releases                                              | 100 MB |
| 40-APP  | Inkscape     | 1.4.2       | https://inkscape.org/release/                                                               | 124 MB |
| 40-APP  | SourceGit+   | 2025.26     | https://github.com/sourcegit-scm/sourcegit/releases/                                        |  24 MB |
| 40-APP  | Theia IDE+   | 1.63        | https://theia-ide.org/#theiaidedownload                                                     | 382 MB |
|         |              |             |                                                                                             |        |
| drivers | PgSQL driver | 42.7.7      | https://jdbc.postgresql.org/download/                                                       |   1 MB |
| drivers | MySql driver | 9.2.0       | https://dev.mysql.com/downloads/connector/j/                                                |   5 MB |
| drivers | MSSql driver | 12.10.0     | https://docs.microsoft.com/en-us/sql/connect/jdbc/microsoft-jdbc-driver-for-sql-server      |   8 MB |
|         |              |             |                                                                                             |        |


### Notes
- [Lapce](https://github.com/lapce/lapce/releases) not working for now. exclude till resolved
- Not used on all machines, exclude unless needed
	- [SQLeoVQB](https://sourceforge.net/projects/sqleo/files/SQLeoVQB/)
	- [ecode](https://github.com/SpartanJ/ecode/releases)
	- [Pulsar](https://github.com/pulsar-edit/pulsar/releases/)
	- [FileZilla](https://filezilla-project.org/download.php?show_all=1)
	- [SnowFlake](https://github.com/subhra74/snowflake/releases)
	- [SourceGit](https://github.com/sourcegit-scm/sourcegit/releases/)
	- [Theia IDE](https://theia-ide.org/#theiaidedownload)

### Other:
- https://jdk.java.net/archive/
- https://docs.microsoft.com/en-us/sql/connect/jdbc/download-microsoft-jdbc-driver-for-sql-server
- https://www.visual-paradigm.com/download/community.jsp?platform=windows&arch=64bit&install=no
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

## scaffold working directories
> Do before starting downloads
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
