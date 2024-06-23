# fdd
Automation scripts to bring a raw ubuntu installation to a known state

---

## Before Running

1. In setup-fdd.sh, Line 8
	- Change `plain_text_password` to 'Actual password'

---

## Quick Download Links
- Updated on: 2024-06-19

| Loc     | App          | Curr Ver  | Download URL                                                                                |   Size |
| ------- | ------------ | --------- | ------------------------------------------------------------------------------------------- | ------:|
| 10-Base | .NET SDK     | 8.0.302   | https://www.microsoft.com/net/download/linux                                                | 212 MB | *
| 10-Base | Java SDK     | 22.0.1    | https://jdk.java.net/                                                                       | 193 MB |
| 10-Base | node.js      | 20.12.2   | https://nodejs.org/en/download/                                                             |  25 MB | *
|         |              |           |                                                                                             |        |
| 20-DEV  | VS Code      | 1.89.0    | https://code.visualstudio.com/docs/?dv=linux64                                              | 138 MB | *
| 20-DEV  | VPUML        | 17.2.0608 | https://www.visual-paradigm.com/download/community.jsp?platform=linux&arch=64bit&install=no | 747 MB | *
| 20-DEV  | SQLeoVQB     | 19.01rc1  | https://sourceforge.net/projects/sqleo/files/SQLeoVQB/                                      |   3 MB |
| 20-DEV  | DBeaver      | 24.1.0    | https://dbeaver.io/download/                                                                | 122 MB | *
| 20-DEV  | CudaText     | 1.215.0.2 | https://sourceforge.net/projects/cudatext/files/release/                                    |   7 MB | *
|         |              |           |                                                                                             |        |
| 30-EXT  | Lite XL      | 2.1.4     | https://github.com/lite-xl/lite-xl/releases                                                 |   2 MB |
| 30-EXT  | Textadept    | 12.4      | https://orbitalquark.github.io/textadept/                                                   |   7 MB |
| 30-EXT  | ecode        | 0.5.2     | https://github.com/SpartanJ/ecode/releases                                                  |  22 MB |
| 30-EXT  | Pulsar       | 1.118.0   | https://github.com/pulsar-edit/pulsar/releases/                                             | 213 MB | *
| 30-EXT  | FileZilla    | 3.67.0    | https://filezilla-project.org/download.php?show_all=1                                       |  15 MB |
| 30-EXT  | SnowFlake    | 1.0.4     | https://github.com/subhra74/snowflake/releases                                              |  39 MB |
|         |              |           |                                                                                             |        |
| drivers | PgSQL driver | 42.7.3    | https://jdbc.postgresql.org/download/                                                       |   1 MB |
| drivers | MySql driver | 8.4.0     | https://dev.mysql.com/downloads/connector/j/                                                |   4 MB |
| drivers | MSSql driver | 12.6.1    | https://docs.microsoft.com/en-us/sql/connect/jdbc/microsoft-jdbc-driver-for-sql-server      |   8 MB |
|         |              |           |                                                                                             |        |

### Notes
- [Lapce](https://github.com/lapce/lapce/releases) not working for now. exclude till resolved

### Other:
- https://docs.microsoft.com/en-us/sql/connect/jdbc/download-microsoft-jdbc-driver-for-sql-server
- https://www.visual-paradigm.com/download/community.jsp?platform=windows&arch=64bit&install=no
---

## scaffold working directories
> Do before starting downloads
```sh
mkdir -vp 10-Apps/10-Base/drivers;
mkdir -vp 10-Apps/20-DEV;
mkdir -vp 10-Apps/30-EXT;
mkdir -vp 20-Resources/Copy/bin/;
mkdir -vp 20-Resources/Copy/ShortCuts/;
mkdir -vp 20-Resources/Install/;
mkdir -vp 20-Resources/Install/Mono-TTF;
mkdir -vp 20-Resources/Install/Sans-TTF;
mkdir -vp 20-Resources/Install/Serif-TTF;
```
---
