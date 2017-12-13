# SQL Server on Linux
[Release Notes](https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-release-notes)

## TODO:
- add connection and usage steps from [here](https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-connect-and-query-sqlcmd)
- Drivers to connect to linux instance, from linux app

# Installation Guide: [read online](https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-setup-ubuntu)

## Prepare
1.	Get and Import public repository GPG keys

	`curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -`

2.	Get Microsoft Ubuntu repositories Register
	``` bash
	
	curl https://packages.microsoft.com/config/ubuntu/16.04/mssql-server.list | sudo tee /etc/apt/sources.list.d/mssql-server.list
	
	#
	curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list | sudo tee /etc/apt/sources.list.d/msprod.list
	
	# update the sources list on system
	sudo apt-get update
	```

## Install and Configure
1.	SQL Server
	`sudo apt-get install -y mssql-server`
2.	Tools - sqlcmd and bcp
	`sudo apt-get install mssql-tools unixodbc-dev`
9.	Configure
	`sudo /opt/mssql/bin/mssql-conf setup`
9.	Optional: Add /opt/mssql-tools/bin/ to your PATH environment variable in a bash shell.
	-	for login sessions, modify your PATH in the ~/.bash_profile
	-	for interactive/non-login sessions, modify the PATH in the ~/.bashrc

9.	Verify Service
	`systemctl status mssql-server`

## Connect to SQL Server on Linux [read online](https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-connect-and-query-sqlcmd)


## Upgrade
Re-run the installation command, this will upgrade the specific mssql-server package:
	```
	sudo apt-get install mssql-server
	sudo apt-get install mssql-tools 	#
	```

