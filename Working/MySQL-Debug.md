# MySQL default setup - Debug

## Working option

```sql
-- generate random password
sudo openssl rand -hex
-- Create new user, with workbench access
CREATE USER 'sak'@'localhost' IDENTIFIED BY 'some-password-text';
GRANT ALL PRIVILEGES ON * . * TO 'sak'@'localhost';
GRANT GRANT OPTION ON * . * TO 'sak'@'localhost';

-- Verify access
SHOW GRANTS for sak@localhost;
FLUSH PRIVILEGES;

-- Show all users in system
SELECT User, Host, plugin, password_expired, password_last_changed, password_lifetime, account_locked  FROM mysql.user;

-- Change password, if dumb enough to run above command without reading
ALTER USER 'sak'@'localhost' IDENTIFIED BY 'new-password-here';
```

## Commands for SystemD

| Command                           | Result                                           |
|:--------------------------------- |:------------------------------------------------ |
| `sudo systemctl start mysql`      | Start Server                                     |
| `sudo systemctl stop mysql`       | Stop Server                                      |
| `sudo systemctl status mysql`     | Show current status of the server                |
| `sudo systemctl restart mysql`    | Restart Server                                   |
| `sudo journalctl -u mysql`        | Show last few lines of Server log                |
| `sudo journalctl -u mysql -f`     | Like tail, continues till (Q)uit                 |
| `sudo systemctl disable mysql`    | Turn off auto-start on stsyem boot               |
| `sudo systemctl is-enabled mysql` | Show current setting for autostart               |
| `sudo systemctl status`           | Show status Formatted all services on the system |

## Misc Notes
- mysql-workbench
- /etc/mysql/mysql.cnf

## Install

### Prereq
- Add cert `20-Resources/certs/mysql-build@oss.oracle.com`
	- `sudo apt-key add path/to/signature-file`
- Add Repo
	- `TBD put actual command here`
	- `deb http://repo.mysql.com/apt/ubuntu/ focal mysql-8.0 mysql-tools`
- Verify downloads
	- `gpg --import mysql_pubkey.asc`
	- both files are stored in the same directory (mysql-standard-8.0.24-linux-i686.tar.gz, mysql-standard-8.0.24-linux-i686.tar.gz.asc)
	- `gpg --verify mysql-standard-8.0.24-linux-i686.tar.gz.asc`

### Install
- mysql-workbench-community
	- `sudo apt-get install mysql-workbench-community`

### Consolidated
```sh
sudo apt-key add ${RESOURCE_FOLDER}/certs/mysql-build@oss.oracle.com
echo "deb [arch=amd64] deb http://repo.mysql.com/apt/ubuntu/ focal mysql-8.0 mysql-tools" | sudo tee -a /etc/apt/sources.list.d/mysql.list;
sudo apt-get update
sudo apt-get install mysql-server mysql-workbench-community
```

### Notes
- Output extract to follow up on
```sh
update-alternatives: using /etc/mysql/mysql.cnf to provide /etc/mysql/my.cnf (my.cnf) in auto mode
```
