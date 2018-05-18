# MySQL default setup - Debug

## Working option

```sql
-- Create new user, with workbench access
CREATE USER 'sak'@'localhost' IDENTIFIED BY 'some-password-text';
GRANT ALL PRIVILEGES ON * . * TO 'sak'@'localhost';
GRANT GRANT OPTION ON * . * TO 'sak'@'localhost';

-- Verify access
SHOW GRANTS for sak@localhost;
FLUSH PRIVILEGES;

-- Show all users in system
SELECT User, Host, plugin, password_expired, password_last_changed, password_lifetime, account_locked  FROM mysql.user;

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
