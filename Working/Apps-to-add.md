## Chromium Browser
> Both download for XCopy. Run trails to confirm updates are possible.
> Prefer Chromium

### Chrome for Testing
- https://googlechromelabs.github.io/chrome-for-testing/last-known-good-versions-with-downloads.json
    - Use latest release link and download

### Chromium
- Get latest release from
    - https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/Linux_x64%2FLAST_CHANGE?alt=media
    - `1449244`
- Filter in
    - https://commondatastorage.googleapis.com/chromium-browser-snapshots/index.html?prefix=Linux_x64/
- Using latest release number
    - https://commondatastorage.googleapis.com/chromium-browser-snapshots/index.html?prefix=Linux_x64/1449244/
- Get
    - https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/Linux_x64%2F1449244%2Fchrome-linux.zip?generation=1745139864940026&alt=media
    - https://www.googleapis.com/storage/v1/b/chromium-browser-snapshots/o/Linux_x64%2F1449244%2Fchrome-linux.zip
    - https://www.googleapis.com/storage/v1/b/chromium-browser-snapshots/o/Linux_x64%2F1449244%2Fchromedriver_linux64.zip
#### Security Policy
    - https://chromium.googlesource.com/chromium/src/+/main/docs/security/apparmor-userns-restrictions.md
    - /etc/apparmor.d/chrome
    - /etc/apparmor.d/chromium
    ```sh
    export CHROME_DEVEL_SANDBOX=/opt/google/chrome/chrome-sandbox
    ```

***

## Cherry Tree
- https://www.giuspen.net/cherrytree/#downl
    - https://www.giuspen.net/software/CherryTree-1.4.0-x86_64.AppImage
- https://github.com/giuspen/cherrytree/releases
    - https://github.com/giuspen/cherrytree/releases/download/v1.4.0/CherryTree-1.4.0-x86_64.AppImage
    - https://github.com/giuspen/cherrytree
    - https://github.com/giuspen/cherrytree/blob/master/data/manual-install.txt
        - https://github.com/giuspen/cherrytree/blob/master/data/cherrytree.desktop

## Git GUI Client
- https://github.com/sourcegit-scm/sourcegit
    - https://github.com/git-ecosystem/git-credential-manager
- https://wiki.gnome.org/Apps/Gitg/

***
