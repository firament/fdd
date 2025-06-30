# fdd
Automation scripts to bring a raw ubuntu installation to a known state

---

## Before Running

1. In setup-fdd.sh, Line 8
	- Change `plain_text_password` to 'Actual password'

---

## Quick Download Links
- Updated on: 2024-06-19

| Loc     | App          | Curr Ver    | Download URL                                                                                |   Size |
| ------- | ------------ | ----------- | ------------------------------------------------------------------------------------------- | ------:|
| 10-Base | .NET SDK     | 24.0.1      | https://www.microsoft.com/net/download/linux                                                | 204 MB |
| 10-Base | Java SDK     | 24.0.1      | https://jdk.java.net/                                                                       | 202 MB |
| 10-Base | node.js      | 22.14.0     | https://nodejs.org/en/download/                                                             |  29 MB |
| 10-Base | Chromium     | 1463259     | Working/Apps-to-add.md#Chromium                                                             | 195 MB |
|         |              |             |                                                                                             |        |
| 20-DEV  | VS Code      | 1.100.0     | https://code.visualstudio.com/docs/?dv=linux64                                              | 142 MB |
| 20-DEV  | VSCodium     | 1.100.23258 | https://github.com/VSCodium/vscodium/releases                                               | 137 MB |
| 20-DEV  | VPUML        | 17.2.0501   | https://www.visual-paradigm.com/download/community.jsp?platform=linux&arch=64bit&install=no | 762 MB |
| 20-DEV  | SQLeoVQB     | 19.01rc1    | https://sourceforge.net/projects/sqleo/files/SQLeoVQB/                                      |   3 MB |
| 20-DEV  | DBeaver      | 25.0.5      | https://dbeaver.io/download/                                                                | 126 MB |
| 20-DEV  | CudaText     | 1.223.6.0   | https://sourceforge.net/projects/cudatext/files/release/                                    |   7 MB |
| 20-DEV  | Textadept    | 12.6        | https://orbitalquark.github.io/textadept/                                                   |   7 MB |
|         |              |             |                                                                                             |        |
| 30-EXT  | Lite XL      | 2.1.8       | https://github.com/lite-xl/lite-xl/releases                                                 |   2 MB |
| 30-EXT  | ecode        | 0.7.1       | https://github.com/SpartanJ/ecode/releases                                                  |  23 MB |
| 30-EXT  | Pulsar       | 1.128.0     | https://github.com/pulsar-edit/pulsar/releases/                                             | 214 MB |
| 30-EXT  | FileZilla    | 3.69.1      | https://filezilla-project.org/download.php?show_all=1                                       |  12 MB |
| 30-EXT  | SnowFlake    | 1.0.4       | https://github.com/subhra74/snowflake/releases                                              |  39 MB |
|         |              |             |                                                                                             |        |
| 40-APP  | CherryTree   | 1.4.0       | https://github.com/giuspen/cherrytree/releases                                              | 108 MB |
| 40-APP  | Theia IDE    | 1.60        | https://theia-ide.org/#theiaidedownload                                                     | 374 MB |
| 40-APP  | SourceGit    | 2025.18     | https://github.com/sourcegit-scm/sourcegit/releases/                                        |  22 MB |
| 40-APP  | Git Cred Mgr | 2.6.1       | https://github.com/git-ecosystem/git-credential-manager/                                    |  27 MB |
| 40-APP  | Inkscape     | 1.4.2       | https://inkscape.org/release/                                                               | 124 MB |
|         |              |             |                                                                                             |        |
| drivers | PgSQL driver | 42.7.5      | https://jdbc.postgresql.org/download/                                                       |   1 MB |
| drivers | MySql driver | 9.2.0       | https://dev.mysql.com/downloads/connector/j/                                                |   5 MB |
| drivers | MSSql driver | 12.10.0     | https://docs.microsoft.com/en-us/sql/connect/jdbc/microsoft-jdbc-driver-for-sql-server      |   8 MB |
|         |              |             |                                                                                             |        |
| Install | Opera        | 119.0.5497  | https://download.opera.com/download/get/?partner=www&opsys=Linux                            | 122 MB |
|         |              |             |                                                                                             |        |


### Notes
- [Lapce](https://github.com/lapce/lapce/releases) not working for now. exclude till resolved

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
