# shellcheck shell=bash
######################################################################
#<
#
# Function: p6df::modules::shell::deps()
#
#>
######################################################################
p6df::modules::shell::deps() {
  ModuleDeps=(
    p6m7g8-dotfiles/p6common
  )
}

######################################################################
#<
#
# Function: p6df::modules::shell::external:::home::symlink()
#
#  Environment:	 P6_DFZ_SRC_DIR P6_DFZ_SRC_P6M7G8_DOTFILES_DIR USER
#>
######################################################################
p6df::modules::shell::external:::home::symlink() {

  p6_file_symlink "$P6_DFZ_SRC_DIR/$USER/home-private/gnupg" ".gnupg"
  p6_file_symlink "$P6_DFZ_SRC_P6M7G8_DOTFILES_DIR/p6df-shell/share/.parallel"

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::shell::external::yum()
#
#>
######################################################################
p6df::modules::shell::external::yum() {

  sudo amazon-linux-extras install epel
  sudo yum install ShellCheck

  wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/bin/yq
  sudo chmod +x /usr/bin/yq

  sudo yum install jq
  sudo yum install recode
  sudo yum install screen
  sudo yum install tmux
  sudo yum install tree
  sudo yum install curl
  sudo yum install wget
  sudo yum install lsof

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::shell::vscodes()
#
#>
######################################################################
p6df::modules::shell::vscodes() {

  # shell
  p6df::core::homebrew::cli::brew::install shfmt
  p6df::modules::vscode::extension::install foxundermoon.shell-format

  p6df::modules::vscode::extension::install timonwong.shellcheck
  p6df::modules::vscode::extension::install jetmartin.bats
  p6df::modules::vscode::extension::install ms-vscode-remote.remote-ssh

  p6_return_void
}

######################################################################
#<
#
# Function: str json = p6df::modules::shell::vscodes::config()
#
#  Returns:
#	str - json
#
#>
######################################################################
p6df::modules::shell::vscodes::config() {

  cat <<'EOF'
  "[shellscript]": {
    "editor.defaultFormatter": "foxundermoon.shell-format"
  },
  "shellcheck.customArgs": ["-x", "--severity=error"],
  "shellcheck.enableQuickFix": true
EOF

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::shell::external::brew()
#
#>
######################################################################
p6df::modules::shell::external::brew() {

  p6df::core::homebrew::cli::brew::install lsd

  brew tap sbdchd/skim
  p6df::core::homebrew::cli::brew::install skim --cask

  p6df::core::homebrew::cli::brew::install fzf

  p6df::core::homebrew::cli::brew::install aspell
  p6df::core::homebrew::cli::brew::install coreutils
  p6df::core::homebrew::cli::brew::install parallel

  p6df::core::homebrew::cli::brew::install shellcheck

  brew tap kaos/shell
  p6df::core::homebrew::cli::brew::install bats-core
  p6df::core::homebrew::cli::brew::install bats-file
  p6df::core::homebrew::cli::brew::install bats-assert
  p6df::core::homebrew::cli::brew::install bats-mock

  p6df::core::homebrew::cli::brew::install jc
  p6df::core::homebrew::cli::brew::install jp
  p6df::core::homebrew::cli::brew::install jq
  p6df::core::homebrew::cli::brew::install yq

  p6df::core::homebrew::cli::brew::install recode

  p6df::core::homebrew::cli::brew::install tree

  p6df::core::homebrew::cli::brew::install aria2
  p6df::core::homebrew::cli::brew::install curl
  p6df::core::homebrew::cli::brew::install wget
  p6df::core::homebrew::cli::brew::install httpie --formula
  p6df::core::homebrew::cli::brew::install mtr

  p6df::core::homebrew::cli::brew::install xz

  p6df::core::homebrew::cli::brew::install z

  p6df::core::homebrew::cli::brew::install htop
  p6df::core::homebrew::cli::brew::install lsof

  p6df::core::homebrew::cli::brew::install bgrep
  p6df::core::homebrew::cli::brew::install cgrep
  p6df::core::homebrew::cli::brew::install grepcidr
  p6df::core::homebrew::cli::brew::install ngrep
  p6df::core::homebrew::cli::brew::install pgrep
  p6df::core::homebrew::cli::brew::install pdfgrep
  p6df::core::homebrew::cli::brew::install psgrep
  p6df::core::homebrew::cli::brew::install ripgrep-all

  p6df::core::homebrew::cli::brew::install gpg
  p6df::core::homebrew::cli::brew::install gnupg
  p6df::core::homebrew::cli::brew::install pass
  p6df::core::homebrew::cli::brew::install pinentry-mac
  p6df::core::homebrew::cli::brew::install netcat

  p6df::core::homebrew::cli::brew::install ffmpeg
  arch -arm64 p6df::core::homebrew::cli::brew::install imagemagick

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::shell::aliases::init(_module, dir)
#
#  Args:
#	_module -
#	dir -
#
#  Environment:	 LSCOLORS OSTYPE TERM USER
#>
######################################################################
p6df::modules::shell::aliases::init() {
  local _module="$1"
  local dir="$2"

  alias '_'='sudo'
  alias rmrf='rm -rf'
  alias cpr='cp -R'
  alias mvf='mv -f'
  alias bclq='bc -lq'
  alias grepr='grep -R'

  alias j='jobs -l'
  alias h='history 25'
  alias duh='du -h'
  alias history='fc -l 1'

  alias 256color="export TERM=xterm-256color"
  alias prettyjson="python -mjson.tool"

  alias myip="dig +short myip.opendns.com @resolver1.opendns.com"

  alias whichlinux='uname -a; cat /etc/*release; cat /etc/issue'

  alias netstat='netstat -an -p tcp'
  alias listen='netstat -an -p tcp | p6_filter_row_select LISTEN'
  alias listenu='netstat -an -p udp'
  alias established='netstat -an -p tcp | p6_filter_row_select ESTABLISHED'

  alias tarx='tar -xvzof'
  alias tart='tar -tvzf'

  alias -g me='| p6_filter_row_select $USER'
  alias -g ng='| p6_filter_row_exclude_regex "\.git"'

  alias xclean='p6_xclean'

  p6_env_export LSCOLORS "Gxfxcxdxbxegedabagacad"
  case "$OSTYPE" in
  freebsd* | darwin*) alias ll='ls -alFGTh' ;;
  *) alias ll='/bin/ls -alFh --color=auto' ;;
  esac

  alias ssh_key_check=p6_ssh_key_check

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::shell::path::init()
#
#  Environment:	 HOMEBREW_PREFIX
#>
######################################################################
p6df::modules::shell::path::init() {

  p6_path_if "$HOMEBREW_PREFIX/opt/lsof/bin" "prepend"
  p6_path_if "$HOMEBREW_PREFIX/opt/curl/bin" "prepend"

  p6_return_void
}

######################################################################
#<
#
# Function: stream  = p6_shell_tcp_is(port)
#
#  Args:
#	port -
#
#  Returns:
#	stream - 
#
#>
######################################################################
p6_shell_tcp_is() {
  local port="$1"

  lsof -iTCP:"$port" -sTCP:LISTEN -n -P

  p6_return_stream
}
