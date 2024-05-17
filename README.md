# fdd
Automation scripts to bring a raw ubuntu installation to a known state

---

## Before Running

1. In setup-fdd.sh, Line 8
	- Change `plain_text_password` to 'Actual password'

---

## Quick Download Links
- Updated on: 2024-05-04

| App          | Curr Ver  | Download URL                                                                                |   Size |
| ------------ | --------- | ------------------------------------------------------------------------------------------- | -----: |
| .NET SDK     | 8.0.204   | https://www.microsoft.com/net/download/linux                                                | 216 MB |
| Java SDK     | 22.0.1    | https://jdk.java.net/                                                                       | 193 MB |
| node.js      | 20.12.2   | https://nodejs.org/en/download/                                                             |  25 MB |
|              |           |                                                                                             |        |
| VS Code      | 1.89.0    | https://code.visualstudio.com/docs/?dv=linux64                                              | 137 MB |
| VPUML        | 17.1.0307 | https://www.visual-paradigm.com/download/community.jsp?platform=linux&arch=64bit&install=no | 766 MB |
| SQLeoVQB     | 19.01rc1  | https://sourceforge.net/projects/sqleo/files/SQLeoVQB/                                      |   3 MB |
| DBeaver      | 24.0.3    | https://dbeaver.io/download/                                                                |  86 MB |
| CudaText     | 1.214.2.0 | https://sourceforge.net/projects/cudatext/files/release/                                    |   7 MB |
|              |           |                                                                                             |        |
| FileZilla    | 3.67.0    | https://filezilla-project.org/download.php?show_all=1                                       |  15 MB |
| SnowFlake    | 1.0.4     | https://github.com/subhra74/snowflake/releases                                              |  39 MB |
|              |           |                                                                                             |        |
| PgSQL driver | 42.7.3    | https://jdbc.postgresql.org/download/                                                       |   1 MB |
| MySql driver | 8.4.0     | https://dev.mysql.com/downloads/connector/j/                                                |   4 MB |
| MSSql driver | 12.6.1    | https://docs.microsoft.com/en-us/sql/connect/jdbc/microsoft-jdbc-driver-for-sql-server      |   8 MB |
|              |           |                                                                                             |        |

### Other:
- https://docs.microsoft.com/en-us/sql/connect/jdbc/download-microsoft-jdbc-driver-for-sql-server
- https://www.visual-paradigm.com/download/community.jsp?platform=windows&arch=64bit&install=no
***

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

