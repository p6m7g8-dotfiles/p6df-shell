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
    p6m7g8-dotfiles/p6shell
  )
}

######################################################################
#<
#
# Function: p6df::modules::shell::external:::home::symlink()
#
#  Environment:	 P6_DFZ_SRC_DIR P6_DFZ_SRC_P6M7G8_DOTFILES_DIR
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

  wget https://github.com/mikefarah/yq/releases/download/v4.6.3/yq_linux_amd64.tar.gz -O - | tar xz
  sudo mv yq_linux_amd64 /usr/bin/yq

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
  brew install shfmt

  code --install-extension foxundermoon.shell-format
  code --install-extension jetmartin.bats
  code --install-extension timonwong.shellcheck
  code --install-extension ms-vscode-remote.remote-ssh
  code --install-extension ms-vscode-remote.remote-ssh-edit

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::shell::external::brew()
#
#  Environment:	 _64
#>
######################################################################
p6df::modules::shell::external::brew() {

  brew tap sbdchd/skim
  brew install skim

  brew install fzf

  brew install aspell
  brew install coreutils
  brew install parallel

  brew install shellcheck

  brew tap kaos/shell
  brew install bats-core
  brew install bats-file
  brew install bats-assert
  brew install bats-mock

  brew install jc
  brew install jp
  brew install jq
  brew install yq

  brew install recode

  brew install tree

  brew install aria2
  brew install curl
  brew install wget
  brew install httpie
  brew install mtr

  brew install xz

  brew install z

  brew install htop
  brew install lsof

  brew install bgrep
  brew install cgrep
  brew install grepcidr
  brew install ngrep
  brew install pgrep
  brew install pdfgrep
  brew install psgrep
  brew install ripgrep-all

  brew install gpg
  brew install gnupg
  brew install pass
  brew install pinentry-mac
  brew install netcat

  brew install ffmpeg
  arch -arm64 brew install imagemagick

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::shell::aliases::init()
#
#  Environment:	 ESTABLISHED FGT LISTEN LSCOLORS OSTYPE TCP TERM USER
#>
######################################################################
p6df::modules::shell::aliases::init() {

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

  alias flushdns='sudo dscacheutil -flushcache'
  alias whotunes='lsof -r 2 -n -P -F n -c iTunes -a -i TCP@`hostname`:3689'

  alias netstat='netstat -an -p tcp'
  alias listen='netstat -an -p tcp | grep LISTEN'
  alias listenu='netstat -an -p udp'
  alias established='netstat -an -p tcp | grep ESTABLISHED'

  alias tarx='tar -xvzof'
  alias tart='tar -tvzf'

  alias -g me="| grep $USER"
  alias -g ng='| grep -v "\.git"'

  alias xclean='p6_xclean'
  alias replace='p6df::modules::shell:replace'
  alias proxy_off='p6df::modules::shell::proxy::off'

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
# Function: p6df::modules::shell::completions::init(module, dir)
#
#  Args:
#	module -
#	dir -
#
#  Environment:	 XXX
#>
######################################################################
p6df::modules::shell::completions::init() {
  local module="$1"
  local dir="$1"

  # XXX: not here
  zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::shell:replace(from, to)
#
#  Args:
#	from -
#	to -
#
#>
######################################################################
p6df::modules::shell:replace() {
  local from="$1"
  local to="$2"

  find . -type f |
    egrep -v '/.git/|/elpa/' |
    xargs grep -l $from |
    xargs perl -pi -e "s,$from,$to,g"

  p6_return_void
}
