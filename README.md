# P6's POSIX.2: p6df-shell

## Table of Contents

- [Badges](#badges)
- [Summary](#summary)
- [Contributing](#contributing)
- [Code of Conduct](#code-of-conduct)
- [Usage](#usage)
  - [Aliases](#aliases)
  - [Functions](#functions)
- [Hierarchy](#hierarchy)
- [Author](#author)

## Badges

[![License](https://img.shields.io/badge/License-Apache%202.0-yellowgreen.svg)](https://opensource.org/licenses/Apache-2.0)

## Summary

TODO: Add a short summary of this module.

## Contributing

- [How to Contribute](<https://github.com/p6m7g8-dotfiles/.github/blob/main/CONTRIBUTING.md>)

## Code of Conduct

- [Code of Conduct](<https://github.com/p6m7g8-dotfiles/.github/blob/main/CODE_OF_CONDUCT.md>)

## Usage

### Aliases

- `256color` -> `export TERM=xterm-256color`
- `_` -> ``
- `bclq` -> `bc -lq`
- `cpr` -> `cp -R`
- `duh` -> `du -h`
- `established` -> `netstat -an -p tcp | p6_filter_row_select ESTABLISHED`
- `grepr` -> `grep -R`
- `h` -> `history 25`
- `history` -> `fc -l 1`
- `j` -> `jobs -l`
- `listen` -> `netstat -an -p tcp | p6_filter_row_select LISTEN`
- `listenu` -> `netstat -an -p udp`
- `ll` -> `/bin/ls -alFh --color=auto`
- `mvf` -> `mv -f`
- `myip` -> `dig +short myip.opendns.com @resolver1.opendns.com`
- `netstat` -> `netstat -an -p tcp`
- `prettyjson` -> `python -mjson.tool`
- `rmrf` -> `rm -rf`
- `ssh_key_check` -> `p6_ssh_key_check`
- `tart` -> `tar -tvzf`
- `tarx` -> `tar -xvzof`
- `whichlinux` -> `uname -a; cat /etc/*release; cat /etc/issue`
- `xclean` -> `p6_xclean`

### Functions

#### p6df-shell

##### p6df-shell/init.zsh

- `p6df::modules::shell::aliases::init(_module, dir)`
  - Args:
    - _module
    - dir
- `p6df::modules::shell::deps()`
- `p6df::modules::shell::external::brews()`
- `p6df::modules::shell::home::symlinks()`
- `p6df::modules::shell::path::init(_module, _dir)`
  - Args:
    - _module
    - _dir
- `p6df::modules::shell::vscodes()`
- `p6df::modules::shell::vscodes::config()`

#### p6df-shell/lib

##### p6df-shell/lib/tcp.zsh

- `stream  = p6_shell_tcp_is(port)`
  - Args:
    - port

## Hierarchy

```text
.
├── init.zsh
├── lib
│   └── tcp.zsh
├── README.md
└── share

3 directories, 3 files
```

## Author

Philip M. Gollucci <pgollucci@p6m7g8.com>
