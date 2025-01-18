# SSH Service
> WIP
> For usage, replace place holders with values
> - `${USER}`
> - `${machine-name}`

### On Server
- [ ] Install service and verify port
  ```sh
	sudo apt install openssh-server
	netstat -tulp
  ```
- [ ] In `/etc/ssh/sshd_config`
  - [ ] turn off pwd auth `PasswordAuthentication no`
  - [ ] enforce key only auth
  - [ ] Set port `Port 22`
- [ ] In `/lib/systemd/system/ssh.socket`
  - [ ] If file exists only
  - [ ] Set port `ListenStream=22`
- [ ] Manage service state
	```
	sudo systemctl status ssh
	sudo systemctl enable ssh
	sudo systemctl start ssh
	sudo systemctl stop ssh
	
  # for modern ssh servers, include socket service also
  sudo systemctl status ssh.socket
  sudo systemctl start ssh.socket
  sudo systemctl stop ssh.socket
	```
	
### On Client
- [ ] Create key-pair (for each host)
  - `ssh-keygen -t ed25519 -b 4096 -C "user@${machine-name}" -f /10-Base/files/${machine-name}-ssh`
- [ ] ssh-add pvt key
  - `ssh-add /10-Base/files/${machine-name}-ssh`
  - Copy to `${HOME}/.ssh/`, both pvt and pub key
- [ ] import host fingerprint
  - `ssh-keyscan -H -O hashalg=sha256 -t ed25519 -p 22 192.168.0.101 >> ${HOME}/.ssh/known_hosts`
- [ ] Create entry in `${HOME}/.ssh/config`
	```
	Host mnp14
      HostName 192.168.0.101
      port 22
      User ${USER}
      IdentityFile /10-Base/files/${machine-name}-ssh.pub
	```
- [ ] Add key to Server
  - [ ] update `${HOME}/.ssh/authorized_keys` with pub key
    - [ ] manually from `${HOME}/.ssh/${machine-name}-ssh.pub`
    - [ ] or, with command, run from client
	```sh
	ssh-copy-id -i ${HOME}/.ssh/${machine-name}-ssh.pub -p 22 YOUR_USER_NAME@IP_ADDRESS_OF_THE_SERVER
	```

---
## Working Notes
- /etc/ssh/sshd_config
    - Port 22
    - AllowUsers ${USER}
    - PermitRootLogin no
    - PermitEmptyPasswords no
    - PasswordAuthentication no
    - PublicKeyAuthentication yes

- /lib/systemd/system/ssh.socket
    - ListenStream=22
    
---
