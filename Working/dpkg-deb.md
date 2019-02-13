# dpkg-deb
> Debian package archive (.deb) manipulation tool

## Syntax
`dpkg-deb [option...] command`

- `-x`, `--extract` archive directory
	- Extracts the filesystem tree from a package archive into the specified directory.
	- directory (but not its parents) will be created if necessary, and its permissions modified to match the contents of the package.
	- > See if only files are extracted or control files too.
- `-R`, `--raw-extract` archive directory
	- Extracts the filesystem tree from a package archive into a specified directory, and the control information files into a DEBIAN subdirectory of the specified directory
	- The target directory (but not its parents) will be created if necessary.
	- The input archive is not (currently) processed sequentially, so reading it from standard input («-») is not supported.
- `-v`, `--verbose`
	- Enables verbose output (since dpkg 1.16.1).  This currently only affects --extract making it behave like --vextract.

## Usage
```sh
# cd 'root of project'
# 20-Resources/Install/pinguybuilder_5.1-8_all.deb

# Trail 1
dpkg-deb -vx 20-Resources/Install/pinguybuilder_5.1-8_all.deb Working/PGB;
ll Working/PGB;

# Trail 2
dpkg-deb -vR 20-Resources/Install/pinguybuilder_5.1-8_all.deb Working/PGB-r;
ll Working/PGB-r
```
