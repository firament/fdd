# TODO List
> Not in any specific order
- [ ] Delete dummy shortcuts
    - /usr/share/applications/theia.desktop
    - /usr/share/applications/filezilla3.desktop
- [ ] Check if any of these recommended apps will be helpful
    - git-doc (1:2.53.0-1ubuntu1)
    - git-email (1:2.53.0-1ubuntu1)
    - git-gui (1:2.53.0-1ubuntu1)
    - gitk (1:2.53.0-1ubuntu1)
    - gitweb (1:2.53.0-1ubuntu1)
    - git-cvs (1:2.53.0-1ubuntu1)
    - git-svn (1:2.53.0-1ubuntu1)
    - molly-guard (0.8.5build1)
    - monkeysphere
    - ssh-askpass (1:1.2.4.1-16build3)
- [ ] Followup on docker install output
    ```
    Synchronizing state of docker.service with SysV service script with /usr/lib/systemd/systemd-sysv-install.
    Executing: /usr/lib/systemd/systemd-sysv-install disable docker
    Removed '/etc/systemd/system/multi-user.target.wants/docker.service'.
    Disabling 'docker.service', but its triggering units are still active:
    docker.socket
    Removed '/etc/systemd/system/multi-user.target.wants/containerd.service'.
    ```
- [ ] https://www.qownnotes.org/getting-started/overview.html
- [ ] Add output of `lsb_release -a` in HealthCheck function
    - Check for anything else that will provide meaningful info on host platform
    - Include flavor or desktop info also
    - For use in analysis of usage
- [ ] Make generic `/70-CurrentWork/make-keys.sh`
    - Define arrays and iterate
    - Occasionally used, readability and maintainability over effeciency
    - Data in markdown format preferred for readability, `org | identity | note`
- [ ] Identify and add VSCode extensions for
    - [ ] Docker
    - [ ] Dev Containers
    - [ ] Terraform
- [ ] Add setting/config files for
    - [ ] Codium
    - [ ] Cursor
    - [ ] Cherry Tree
    - [ ] DBeaver
    - [ ] VPUML-CE
- [ ] Create profiles for
    - [ ] VS Code
    - [ ] Codium
    - [ ] Cursor ??
- [ ] Test and add, if it fits workflow
    - [x] [ProjectLibre desktop](https://www.projectlibre.com/projectlibre-desktop/)
    - [ ] [Portainer Community Edition](https://github.com/portainer/portainer)
    - [ ] [SilverBullet](https://github.com/silverbulletmd/silverbullet) or [silverbullet-ai](https://github.com/justyns/silverbullet-ai)
        - Use docker option, with bash launcher
    - [ ] [Eclipse Papyrus Modeling environment](https://eclipse.dev/papyrus/)
- [ ] Start work on pocket OS
    - [ ] [penguins-eggs](https://github.com/pieroproietti/penguins-eggs)
    - [ ] [Ventoy](https://github.com/ventoy/Ventoy)
    - [ ] with UEFI boot support
- [ ] Check/Read
    - [ ] [WinPE](https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/winpe-intro)
    - [ ] [Microsoft Validation OS](https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/validation-os-overview)
- [ ] Add links from `/10-Base/bin` to `/usr/local/sbin`, to enable sudo commands

---

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

---
