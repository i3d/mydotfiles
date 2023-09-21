# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000000
SAVEHIST=10000000

[[ ! -d $HOME/my_completions ]]  && mkdir -p $HOME/my_completions
[[ ! -d $HOME/.local/bin ]]  && mkdir -p $HOME/.local/bin
[[ ! -d $HOME/.config ]]  && mkdir -p $HOME/.config
[[ ! -d $HOME/.local/src ]]  && mkdir -p $HOME/.local/src

if [[ ! -d $HOME/.local/src ]]; then
  mkdir -p $HOME/.local/src
  cd $HOME 1>/dev/null 2>/dev/null
fi

if [[ ! -d $HOME/.local/src/mydotfiles ]]; then
  cd $HOME/.local/src 1>/dev/null 2>/dev/null && \ # startup dependencies
  git clone https://github.com/i3d/mydotfiles.git && \
  echo "mydotfiles is installed to $HOME/.local/src. Needs to be manually copied ..."
  sleep 3
fi

#git clone https://github.com/Parth/dotfiles.git
# if [[ ! -d $HOME/.local/src/zsh-interactive-cd ]]; then
#   git clone https://github.com/changyuheng/zsh-interactive-cd.git
# fi
#source $HOME/.local/src/zsh-interactive-cd/zsh-interactive-cd.plugin.zsh
#  git clone https://github.com/i3d/afetch.git
#
###### !!!! VIM mode forever !!!! ########
###### !!!! VIM mode forever !!!! ########
###### !!!! VIM mode forever !!!! ########
autoload -z edit-command-line
zle -N edit-command-line
[[ ! -d $HOME/.local/src/zsh-vimode-visual ]] && \
  mkdir -p $HOME/.local/src 2>/dev/null && \
  cd $HOME/.local/src 1>dev/null 2>/dev/null && \
  git clone https://github.com/b4b4r07/zsh-vimode-visual.git && cd $HOME 1>/dev/null 2>/dev/null
source $HOME/.local/src/zsh-vimode-visual/zsh-vimode-visual.zsh
# neovim as man pager.
#export MANPAGER="/bin/sh -c \"col -b | v -c 'set ft=man ts=8 nomod nolist noma nu' -\""
#export MANPAGER="less -FRX"
export MANPAGER="v +Man!"
export KEYTIMEOUT=1
# https://dougblack.io/words/zsh-vi-mode.html
function zle-line-init zle-keymap-select {
  VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]%  %{$reset_color%}"
  RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/}$(git_prompt_status) $EPS1"
  zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select
###### !!!! VIM mode forever !!!! ########
###### !!!! VIM mode forever !!!! ########
###### !!!! VIM mode forever !!!! ########
export ZSH=$HOME/.oh-my-zsh
###### !!!! VIM mode forever !!!! ########
###### !!!! VIM mode forever !!!! ########
###### !!!! VIM mode forever !!!! ########
# These rust tools are essential, build them first.
[[ -f $HOME/.cargo/env  ]] && source $HOME/.cargo/env
if [[ ! -d $HOME/.cargo ]]; then
  # setup rustup.
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  [[ -f $HOME/.cargo/env  ]] && source $HOME/.cargo/env
  cd $HOME 1>/dev/null 2>/dev/null
  rustup update && rustup default nightly && \
  # install core rust tools.
  # this is close to what rustbinup offers.
  cargo install bat ripgrep git-delta exa procs dutree \
	      lsd fselect hx bingrep find-files xplr ttyper \
	      racer cargo-rls-install hub
fi
# if everything goes well, we should have rustc in PATH.
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
#
# ================ Before sourcing OMZ ====================
# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
#
#ZSH_THEME="terencehill"
#SPACESHIP_BATTERY_SHOW=false
#ZSH_THEME="budspencer"
#ZSH_THEME="agnoster"
#ZSH_THEME="spaceship"
#ZSH_THEME="powerlevel9k/powerlevel9k"
#ZSH_THEME="gitster"
#ZSH_THEME="lambda-gitster"
#ZSH_THEME="lambda-mod"
#ZSH_THEME="psyrendust"
#ZSH_THEME="starlight"
#ZSH_THEME="kinda-fishy"
#ZSH_THEME="bunnyruni"
#

#bad
#ZSH_THEME="lambda-pure"
#ZSH_THEME="agnosterzak"
#ZSH_THEME="zeta"
#ZSH_THEME="haribo"
#ZSH_THEME="bullet-train"
ZSH_THEME="archcraft"
# ================ Before sourcing OMZ ====================
#
# Path to your oh-my-zsh installation.
# Don't put vi-mode as it conflict with zsh-autocomplete
plugins=(z jump rust colorize command-not-found common-aliases copybuffer cp dircycle dirhistory dotenv iterm2 safe-paste macos pip python themes history golang mercurial github brew git)
# for awesome-terminal-fonts
### source $HOME/.local/src/awesome-terminal-fonts/fonts/*.sh
#POWERLEVEL9K_MODE='nerdfont-complete'

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshrc="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# Example aliases
# Set to this to use case-sensitive completion
CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# explicit PATH starts. make sure HOMEBREW_SHELLENV_PREFIX also reset
# so that eval can do the right thing every time.
unset HOMEBREW_SHELLENV_PREFIX
export PATH=/usr/local/bin:/usr/local/sbin:/usr/local/symlinks:/usr/local/scripts:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/bin/g4bin:/usr/X11R6/bin:/usr/local/google/bin
export PATH=$HOME/homebrew/opt/llvm/bin:$PATH:$HOME/.rvm/bin:/$HOME/.rbenv/shims # Add RVM to PATH for scripting
export CSCOPE_DB=$HOME/src/linux/cscope.out
[[ -f $HOME/.cargo/env  ]] && source $HOME/.cargo/env

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ #
#### !!!! All ENV variables setup needed for OMZ and pre-oh-my-zsh ENDs here !!!! #######
#### !!!! All ENV variables setup needed for OMZ and pre-oh-my-zsh ENDs here !!!! #######
source $ZSH/oh-my-zsh.sh                                                          #######
source ~/.zshrc.pre-oh-my-zsh                                                     #######
#### !!!! All ENV variables setup needed for OMZ and pre-oh-my-zsh ENDs here !!!! #######
#### !!!! All ENV variables setup needed for OMZ and pre-oh-my-zsh ENDs here !!!! #######
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ #

[[ -f $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Initialize HOMEBREW PATHs and ENVs before we add our own.
export HOMEBREW_PREFIX=$HOME/homebrew
if ! `echo $PKG_CONFIG_PATH | grep 'homebrew' | grep -v grep >/dev/null`; then
  export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$(find $HOME/homebrew -type d -name "pkgconfig" | tr '\n' ':' | sed 's/.$//')
fi
# we use alternative install because on corp machine /usr/local isn't free of change.
NEED_INSTALL_BREW=0
if [[ ! -d $HOMEBREW_PREFIX ]]; then
  mkdir -p $HOMEBREW_PREFIX 2>/dev/null && \
  	  curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C $HOMEBREW_PREFIX
  # now, we install some base packages.
  # some of the rust based packages will be installed from rust/cargo.
  NEED_INSTALL_BREW=1
fi
export HOMEBREW_INSTALL_CLEANUP=1
eval $(${HOMEBREW_PREFIX}/bin/brew shellenv)
alias python=$HOME/homebrew/bin/python3

# this will take a while
if ((  $NEED_INSTALL_BREW )); then
  # first install build tools
  echo "Install build tools ..."
  brew install \
    autoconf automake base64 bison cmake gcc gettext global intltool \
    m4 nasm readline wget yarn node python ipython && \
  # install core tools
  echo "Install core tools ..."
  brew install \
    git hub asdf autojump fasd fd tldr the_silver_searcher \
    tree tmux zsh zsh-syntax-highlighting zsync alacritty amethyst \
    kitty glow vscodium irssi fontconfig font-firacode-nerd-font \
    font-noto-nerd-font source-highlight lazygit
  echo "Install secondary tools ..."
  # if the above all went well, then install secondary tools
  brew install \
    colormake colortail coreutils cowsay cppcheck cppman \
    cscope ctail diffutils direnv fortune geoip gnu-sed \
    go gotop htop lolcat lsof m-cli mas ncdu multitail mu neofetch \
    nnn pcre pcre2 peco pidof pstree ranger shellcheck shfmt \
    ssh-copy-id tree-sitter  util-macros watch wifi-password
  # everything went well, continue installing 
  echo "Install network tools ..."
  brew install \
    fping geoip hping ifstat iftop iperf mtr nmap speedtest-cli tping \
    tcptraceroute w3m
  # continue installing media apps
  echo "Install media apps ..."
  brew install \
    ffmpeg ffmpeg-iina flac imagemagick media-info mpv mplayershell \
    transmission-cli youtube-dl
  echo "Install other apps ..."
  brew install \
    freetype gdb util-linux typescript universal-ctags \
    mark-text qutebrowser 

  echo "Install node tools ..."
  if [[ ! $(npm update -g --force && npm install -g neovim flake8) ]] ; then
    yarn update && yarn install -g neovim flake8
  fi
fi

# fzf requires go, which comes from homebrew.
#### init fzf ######
if [[ ! -d $HOME/.fzf ]]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
fi

[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
if `which rg &>/dev/null`; then
    #export FZF_DEFAULT_COMMAND='rg --hidden -l ""'
    export FZF_DEFAULT_COMMAND='rg -S --trim --column -H --hidden ""'
else
    # if nothing else, this is the default.
    export FZF_DEFAULT_COMMAND='find .'
fi

if [[ ! -d $HOME/src/vifm ]]; then
  mkdir -p $HOME/src 2>/dev/null && \
  # non startup dependencies.
  cd $HOME/src 1>/dev/null 2>/dev/null && \
  git clone https://github.com/vifm/vifm.git && \
    cd $HOME/src/vifm 1>/dev/null 2>/dev/null && automake && \
    configure --prefix=$HOME/.local --without-X11 && \
    make && make install
fi

# [[ ! -d $HOME/src/Nim ]] && cd $HOME/src 1>/dev/null 2>/dev/null && git clone https://github.com/nim-lang/Nim.git
[[ ! -d $HOME/src/rust ]] && [[ ! -L $HOME/src ]] && cd $HOME/src 1>/dev/null 2>/dev/null && git clone https://github.com/rust-lang/rust.git
[[ ! -d $HOME/go ]] && [[ ! -L $HOME/go ]] && cd $HOME 1>/dev/null 2>/dev/null && git clone https://github.com/golang/go.git 
cd $HOME 1>/dev/null 2>/dev/null

[[ ! -d $HOME/src/ytfzf ]] && [[ ! -L $HOME/src ]] && \
  cd $HOME/src 2>/dev/null && \
  brew install jq && \
  git clone https://github.com/pystardust/ytfzf.git && \
  cp $HOME/src/ytfzf/ytfzf $HOME/.local/bin/ytfzf && cd $HOME >/dev/null
# ytfzf config
export YTFZF_PLAYER="mpv --vd-queue-enable=yes --vd-lavc-threads=4"

[[ ! -d $HOME/src/neovim ]] && [[ ! -L $HOME/src ]] && \
  cd $HOME/src 2>/dev/null && \
  git clone https://github.com/neovim/neovim.git && \
  cd neovim 2>/dev/null && \
  echo "Install neovim.git ..." && \
  mkdir -p $HOME/.local/bin && \
  make distclean && make CMAKE_EXTRA_FLAGS=-DCMAKE_INSTALL_PREFIX=$HOME/.local CMAKE_BUILD_TYPE=Release && \
  make install && \
  cd $HOME 1>/dev/null 2>/dev/null

[[ ! -d $HOME/src/neovide ]] && [[ ! -L $HOME/src ]] && \
  cd $HOME/src 2>/dev/null && \
  git clone https://github.com/neovide/neovide.git  && \
  cd neovide && cargo build --release && \
  mkdir -p $HOME/bin 2>/dev/null && cp target/release/neovide $HOME/bin 2>/dev/null && \
  cd $HOME 1>/dev/null 2>/dev/null

#github qfc
[[ -s "$HOME/.qfc/bin/qfc.sh"  ]] && source "$HOME/.qfc/bin/qfc.sh"
##### !!!! Start plugin managers !!!! ######
##### !!!! Start plugin managers !!!! ######
[[ ! -d $HOME/.zprezto ]] && \
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto" && \
[[ -d $HOME/.zprezto ]] && source $HOME/.zprezto/init.zsh
### Added by zinit's installer
if [[ ! -d ~/.zinit ]];then
  mkdir -p ~/.zinit
  git clone https://github.com/zdharma/zinit.git ~/.zinit/bin
fi
source ~/.zinit/bin/zinit.zsh
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of zinit's installer chunk

###############################
# from https://github.com/lmintmate/zshrc/blob/master/.zshrc
zinit light MichaelAquilina/zsh-auto-notify
zinit light MichaelAquilina/zsh-you-should-use
AUTO_NOTIFY_IGNORE+=("micro")
AUTO_NOTIFY_IGNORE+=("mocp")
export YSU_MESSAGE_POSITION="after"
export LESS_TERMCAP_md=$(tput bold; tput setaf 1)
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_mb=$(tput bold; tput setaf 2)
export LESS_TERMCAP_us=$(tput bold; tput setaf 2)
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
export LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4)
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

zmodload -i zsh/parameter
setopt list_rows_first glob_complete histignoredups ignoreeof correct_all promptsubst
unsetopt flowcontrol

autoload -U colors && colors
export SPROMPT="Correct $fg_bold[red]%R$reset_color to $fg_bold[green]%r?$reset_color ($fg_bold[green]Yes$reset_color, $fg_bold[yellow]No$reset_color, $fg_bold[red]Abort$reset_color, $fg_bold[blue]Edit$reset_color) "
###############################

zinit load zdharma/history-search-multi-word
zinit ice compile"*.lzui" from"notabug"
zinit load zdharma/zui

# One other binary release, it needs renaming from `docker-compose-Linux-x86_64`.
# This is done by ice-mod `mv'{from} -> {to}'. There are multiple packages per
# single version, for OS X, Linux and Windows – so ice-mod `bpick' is used to
# select Linux package – in this case this is not needed, zinit will grep
# operating system name and architecture automatically when there's no `bpick'

zinit ice from"gh-r" as"program" mv"docker* -> docker-compose" bpick"*linux*"; zinit load docker/compose

# Scripts that are built at install (there's single default make target, "install",
# and it constructs scripts by `cat'ing a few files). The make"" ice could also be:
# `make"install PREFIX=$ZPFX"`, if "install" wouldn't be the only, default target

zinit ice as"program" pick"$ZPFX/bin/git-*" make"PREFIX=$ZPFX"
zinit light tj/git-extras

# Two regular plugins loaded in default way (no `zinit ice ...` modifiers)

# local change to the autosuggestions plugin is to add a <space> after the completion is filled to 
# the BUFFER, so that the whole BUFFER has a " " at the end. This does not alter the semantic
# of the complete but should help avoid some weird interactions with fzf/or other completion that
# detects an accept-line at <cr>.
# changed POSTDISPLAY="${suggestion#$BUFFER}"
# to      POSTDISPLAY="${suggestion#$BUFFER} "
ZSH_AUTOSUGGEST_USE_ASYNC=1
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma/fast-syntax-highlighting
zinit light zsh-users/zsh-syntax-highlighting

zinit ice atclone"gdircolors -b LS_COLORS > c.zsh" atpull'%atclone' pick"c.zsh" nocompile'!'
zinit light trapd00r/LS_COLORS

# This one to be ran just once, in interactive session

#zinit ice as"program" make'!' atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' src"zhook.zsh"
#zinit light direnv/direnv

zinit creinstall %HOME/my_completions  # Handle completions without loading any plugin, see "clist" command
# 4/24/2021 fzf utilities
zinit load wfxr/forgit
zinit light kazhala/dotbare
# Load OMZ Git library
zinit snippet OMZ::lib/git.zsh
# Load Git plugin from OMZ
zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit cdclear -q # <- forget completions provided up to this moment
##### end zinit plguin manager #################################

[[ ! -f $HOMEBREW_PREFIX/etc/profile.d/autojump.sh ]] && brew install autojump
[[ -f $HOMEBREW_PREFIX/etc/profile.d/autojump.sh ]] && \
  . $HOMEBREW_PREFIX/etc/profile.d/autojump.sh

# node.js, nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \
  . "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"  # This loads nvm
[ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion" ] && \
  . "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

[[ ! $(which xplr) ]] && brew install --head xplr && mkdir -p $HOME/.config/xplr
#homebrew cleanup previous installs.
#or run this to cleanup.
alias lx='xplr'
alias r='ranger'
alias hbc='~/bin/hbc.sh'
alias bbbb='blaze'
# for oni finding neovim
export ONI_NEOVIM_PATH=$HOME/bin/v

# edit the vimrc.
alias vim='~/.local/bin/vim -u ~/.virc -XOn'
alias vi='vim'
alias v='~/.local/bin/nvim -u ~/.vimrc -XOn'
#alias v='~/homebrew/bin/nvim -u ~/.vimrc -XOn'
alias vv='$HOME/homebrew/bin/nvim -u ~/.vimrc -XOn'
alias av='~/bin/nvim.asdf -u ~/.vimrc -XOn'
alias qv='~/.local/bin/nvim -u ~/.vvimrc -XOn'
alias vc='~/bin/nvim.asdf -u ~/.vimrc -XOn --clean'
alias zshrc="v ~/.zshrc ~/.zshrc.pre-oh-my-zsh"
alias ohmyzsh="v ~/.oh-my-zsh"
alias va='v ~/.vimrc ~/.vimrc.plug'
alias v1='v ~/.vimrc'
alias v2='v ~/.vimrc.plug'
alias v3='v ~/.vim/init.lua'
alias v4='v ~/.vim/lua/plugs.lua'
alias v5='vi ~/.virc'
alias vz='zshrc'
alias z1='v ~/.zshrc'
alias z2='v ~/.zshrc.pre-oh-my-zsh'
alias z3='v ~/.zshenv'
alias vcheat='v $HOME/bin/cheat'
alias cat='bat -pp'
alias less='bat -p'
alias b='less'
alias c='/bin/cat'
alias D='delta -ns --diff-highlight --true-color=auto --paging=always'
alias xv='$HOME/bin/space'
#
# currently using the following zsh prompt themes. either generate one from using vim promptline plguin,
# or use zinit powerlevel9k, both works, or fallback to a fixed liquidprompt.
# having git_prompt_status issue
#source ~/.liquidprompt/liquidprompt
#source ~/.promptline.sh
# ==== load OMZ theme ====
# having issues.
#zinit light NicoSantangelo/Alpharized
# ==== load 3rd_party theme ====
# Load theme from github directly.
# Load the pure theme, with zsh-async library that's bundled with it
# use our own theme
#zinit light tannhuber/oh-my-zsh-budspencer
# ============ was enabled before =======================
#zinit light denysdovhan/spaceship-prompt
#SPACESHIP_BATTERY_SHOW=false
# nice but ugly in vim term.
#zinit light bhilburn/powerlevel9k
# ========== Current prompt ===================
# Disable for starship
# zinit light romkatv/powerlevel10k
# prompt_git:15: unknown group
#zinit light caiogondim/bullet-train.zsh
#BULLETTRAIN_STATUS_EXIT_SHOW=true

fpath+=~/.zfunc
eval "$(hub alias -s)"

[[ ! -d $HOME/.local/src/base16-shell ]] && \
  mkdir -p $HOME/.local/src 2>/dev/null && \
  cd $HOME/.local/src 2>/dev/null && \
  git clone https://github.com/chriskempson/base16-shell.git && \
  cd $HOME 2>/dev/null
BASE16_SHELL="$HOME/.local/src/base16-shell"
[ -n "$PS1" ] && \
[ -s "$BASE16_SHELL/profile_helper.sh" ] && \
  source $BASE16_SHELL/profile_helper.sh

[[ -f $HOME/homebrew/opt/asdf/libexec/asdf.sh ]] && \
  . $HOME/homebrew/opt/asdf/libexec/asdf.sh
alias asif='asdf info'
alias aspa='asdf plugin add'
alias aspl='asdf plugin list'
alias aspp='asdf plugin list all'
alias aspr='asdf plugin remove'
alias aspu='asdf plugin update'
alias asua='asdf plugin update --all'
alias asis='asdf install'
alias asus='asdf uninstall'
alias ascr='asdf current'
alias aswh='asdf where'
alias aswi='asdf which'
alias aslo='asdf local'
alias asgl='asdf global'
alias assh='asdf shell'
alias asst='asdf latest'
alias asls='asdf list'
alias asla='asdf list all'
alias ashl='asdf help'
alias asex='asdf exec'
alias asev='asdf env'
alias asre='asdf reshim'
alias assv='asdf shim-versions'

#

# parth/dotfiles
stty -ixon

# Fix for arrow-key searching
# start typing + [Up-Arrow] - fuzzy find history forward
if [[ "${terminfo[kcuu1]}" != "" ]]; then
	autoload -U up-line-or-beginning-search
	zle -N up-line-or-beginning-search
	bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
# start typing + [Down-Arrow] - fuzzy find history backward
if [[ "${terminfo[kcud1]}" != "" ]]; then
	autoload -U down-line-or-beginning-search
	zle -N down-line-or-beginning-search
	bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
fi

# ===================== Was used before powerlevel10k ==================
#source $HOME/.local/src/dotfiles/zsh/prompt.sh
#export PATH=$PATH:$HOME/.local/src/dotfiles/utils

# for doom emacs
export PATH=$PATH:$HOME/.emacs.d/bin

#######################################################################
#                                                                     #
#     Everything installed into .local/bin can only be referenced     #
#     after this PATH spec !!!                                        #
#                                                                     #
#######################################################################
# for everything that installed into .local/bin/
export PATH=$HOME/.local/bin:$PATH
# bash-hook            # add hook code to bash $PROMPT_COMMAND
# bash-ccomp           # bash command mode completion definitions
# bash-ccomp-install   # setup command mode completion for bash
# posix-alias          # define aliases that applies to all posix shells
# posix-hook           # setup $PS1 hook for shells that's posix compatible
# tcsh-alias           # define aliases for tcsh
# tcsh-hook            # setup tcsh precmd alias
# zsh-hook             # define _fasd_preexec and add it to zsh preexec array
# zsh-ccomp            # zsh command mode completion definitions
# zsh-ccomp-install    # setup command mode completion for zsh
# zsh-wcomp            # zsh word mode completion definitions
# zsh-wcomp-install    # setup word mode completion for zsh

# Example for a minimal zsh setup (no tab completion):
# eval "$(fasd --init posix-alias zsh-hook)"
# Note that this method will slightly increase your shell start-up time, since calling binaries has overhead.  You can cache fasd init code if you want min-
# imal overhead.  Example code for bash (to be put into .bashrc):
fasd_cache="$HOME/.fasd-init-zsh"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
    fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install >| "$fasd_cache"
fi
source "$fasd_cache"
## better zz from fasd
unalias zz 2>/dev/null
function zz() {
  local dir
  dir="$(z | fzf-tmux -1 -0 --no-sort +m | awk '{print $2}')" && cd "${dir}" || return 1
}

function vcp() {
  local p=$1
  # -m supports multi select using tab/shift-tab.
  find ${p%%/} | fzf-tmux -m --preview 'head -50 {}' | while read file; do
    cp $file $2
  done
}

#fish
# always unalias vi
unalias vi 2>/dev/null
# the command in bin/v has some unknown issue with zsh-autocomplete:
# https://github.com/marlonrichert/zsh-autocomplete/issues/322
# so disable it for now and use the alias.
#unalias v 2>/dev/null
unalias g  2>/dev/null # alias to git which never good.
unalias rd 2>/dev/null # for mac remote desktop, not rmdir
unalias cp 2>/dev/null # don't ask.
unalias fd 2>/dev/null # don't alias to find -t f
unalias ff 2>/dev/null # don't alias ff as find file, there is a rust ff binary.
unalias sk 2>/dev/null # sk => skim.
fortune | cowsay -f $(cowsay -l| sed '1d' | shuf | tr ' ' '\n' | head -1) | lolcat
# see https://unix.stackexchange.com/questions/140750/generate-random-numbers-in-specific-range
# or jot -r 1 1 10000
# head -200 /dev/urandom | cksum
#
#cbonsai -s $(shuf -i 1-10000 -n 1) -p
# terminal logo
#screenfetch
neofetch
# afetch  # fast
# don't fatch the IP.
#archey -o

killwal() {
    sleep 3
    if ps -ef|grep $1 &>/dev/null; then
      printf "Killing pywal ..."
      disown $1; kill -9 $1 &>/dev/null
    fi
    sleep 1
    if [[  $(pgrep -f "wal -R" &>/dev/null)  ]]; then
      pid=$(pgrep -f "wal -R")
      printf "Killing pywal ..."
      disown $pid; kill -9 $pid &>/dev/null
    fi
}

# archcraft for now. 5/9/2021
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
#[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# Disable powerlevel9k for now and use starship prompt.
POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off
# Starship prompt starts here.
# eval "$(starship init zsh)"
# zinit light halfo/lambda-mod-zsh-theme
#zinit snippet OMZ::themes/cloud.zsh-theme
#zinit snippet OMZ::themes/cypher.zsh-theme
#zinit snippet OMZ::themes/kolo.zsh-theme
#zinit snippet OMZ::themes/lambda.zsh-theme
#zinit snippet OMZ::themes/lukerandall.zsh-theme
#zinit snippet OMZ::themes/mikeh.zsh-theme
#zinit snippet OMZ::themes/miloshadzic.zsh-theme
#zinit snippet OMZ::themes/muse.zsh-theme
#zinit snippet OMZ::themes/nicoulaj.zsh-theme
#zinit snippet OMZ::themes/norm.zsh-theme
#zinit snippet OMZ::themes/obraun.zsh-theme
#zinit snippet OMZ::themes/afowler.zsh-theme
#zinit ice pick"async.zsh" src"pure.zsh"; zinit light sindresorhus/pure


#autoload -Uz history-beginning-search-menu
#zle -N history-beginning-search-menu
# ctrl-space to call out the history commnad menu.
#bindkey '^Q' history-beginning-search-menu
[[ ! -d $HOME/.local/src/zsh-autocomplete ]] && \
    cd $HOME/.local/src 2>/dev/null && \
    git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git && cd $HOME 2>/dev/null
[[ -f  $HOME/.local/src/zsh-autocomplete/zsh-autocomplete.plugin.zsh ]] && \
     source $HOME/.local/src/zsh-autocomplete/zsh-autocomplete.plugin.zsh
### ============ start zplug init ============= ###
# ### Make plugin here may require dependent commands e.g. fzf, rg, etc
# ### already in path, so make sure this happens after most of the
# ### $PATH is populated
# ###### ==== plugins ====== #####
if [[ ! -d $HOME/.zplug ]]; then
    curl -sL --proto-redir -all,https \
        https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi
source ~/.zplug/init.zsh
# for some reason not work fully with zplug.
#zplug "marlonrichert/zsh-autocomplete"
zplug "zsh-users/zsh-history-substring-search"
# ###### ==== plugins ====== #####

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
### ============ start zplug config ============= ###
### ============ end zplug config ============= ###
# Then, source plugins and add commands to $PATH
zplug load --verbose
# after the plugin loaded.
HISTORY_SUBSTRING_SEARCH_FUZZY=1
### ============ end zplug init ============= ###
export PATH=$PATH:$HOME/.config/nvcode/utils/bin
#### FZF customized key bindings ####
#bindkey -M viins '^x' fzf-history-widget # r for reverse history search
#bindkey -M vicmd 'k' fzf-history-widget
#bindkey -M vicmd 'j' fzf-cd-widget # j for jump
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
#bindkey -M vicmd 'r' fzf-history-widget
bindkey -M vicmd '?' fzf-history-widget
bindkey -M viins '^f' fzf-file-widget # f for file
bindkey -M vicmd 'f' fzf-file-widget # f for file
bindkey -M viins '^j' fzf-cd-widget # j for jump
bindkey -M viins '^t' transpose-chars # t for transpose
bindkey -M viins '\ec' capitalize-word # c for capitalizae
#### FZF customized key bindings ####
# Setup python environment. It should be on >= v3
#if command -v pyenv 1>/dev/null 2>&1; then
#  eval "$(pyenv init -)"
#fi
#
### !!! After zsh-autocomplete !!! #########
#### FZF thems ######
# matrix
# export FZF_DEFAULT_OPTS="--color=bg+:#333333,bg:#091013,gutter:#6fa64c,spinner:#e2e500,hl:#e2e500,fg:#90d762,header:#46d8b8,info:#90d762,pointer:#90d762,marker:#00ff87,fg+:#00ff87,prompt:#00cd6d,hl+:#90d762 --header-lines=0 --ansi --keep-right --info=inline"

# carbondark
export FZF_DEFAULT_OPTS="--color=bg+:#333333,bg:#0E0E0E,gutter:#666666,spinner:#FAFF00,hl:#FAFF00,fg:#929492,header:#7D7D7D,info:#929492,pointer:#929492,marker:#FAFAFA,fg+:#CACACA,prompt:#E6E6E6,hl+:#929492 --header-lines=0 --ansi --keep-right --info=inline"

# serenade
#export FZF_DEFAULT_OPTS="--color=bg+:#3B4346,bg:#2A2F33,gutter:#2A2F33,spinner:#c1bf89,hl:#C76767,fg:#bfddb2,header:#CC9361,info:#87c095,pointer:#82abbc,marker:#c1bf89,fg+:#D49864,prompt:#e5a46b,hl+:#87c095 --header-lines=0 --ansi --keep-right --info=inline"

# molokai
#export FZF_DEFAULT_OPTS='--color=bg+:#293739,bg:#1B1D1E,border:#808080,spinner:#E6DB74,hl:#7E8E91,fg:#F8F8F2,header:#7E8E91,info:#A6E22E,pointer:#A6E22E,marker:#F92672,fg+:#F8F8F2,prompt:#F92672,hl+:#F92672'
#
# gruvbox
#export FZF_DEFAULT_OPTS="--color=bg+:#1B1D1E,bg:#1B1D1E,spinner:#fb4934,hl:#928374,fg:#ebdbb2,header:#928374,info:#8ec07c,pointer:#fb4934,marker:#fb4934,fg+:#ebdbb2,prompt:#fb4934,hl+:#fb4934"

#### FZF thems ######
#
# FZF functions #########################
# https://github.com/junegunn/fzf/wiki/examples#changing-directory
zx() {
  # fasd history jump first, if not, fd.
  [ $# -gt 0 ] && j "$*" && return
  local dir
  dir="$(fasd -Rdl "$1" | fzf -1 -0 --no-sort +m --keep-right)"
  [[ ! -z ${dir} ]] && cd "${dir}" && return

  dir=$(fd -uu -L -i -t d | \
    fzf -1 -0 +m --cycle --keep-right) && cd "$dir" || return 1
}
alias xcd=zx
# command history
zh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -E 's/ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g')
}
alias his=zh
# zkill - kill processes - list only the ones you can kill. Modified the earlier script.
zkill() {
    local pid 
    if [ "$UID" != "0" ]; then
        pid=$(ps -f -u $UID | sed 1d | fzf -m --keep-right --cycle -0 -1| awk '{print $2}')
    else
        pid=$(ps -ef | sed 1d | fzf -m --keep-right --cycle -0 -1| awk '{print $2}')
    fi  

    if [ "x$pid" != "x" ]
    then
        echo $pid | xargs kill -${1:-9}
    fi  
}
alias glNoGraph='git --no-pager log --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr% C(auto)%an" "$@"'
_gitLogLineToHash="echo {} | grep -o '[a-f0-9]\{7\}' | head -1"
#_viewGitLogLine="$_gitLogLineToHash | xargs -I % sh -c 'git --no-pager show --color=always % | D'"
_viewGitLogLine="$_gitLogLineToHash | xargs -I % sh -c 'git --no-pager show --color=always %'"

# zgitco - checkout git commit with previews
zgitco() {
  local commit
  commit=$( glNoGraph |
    fzf --preview-window=up,60%,nofollow --info=inline \
        --no-sort --reverse --tiebreak=index --no-multi \
        --ansi --preview="$_viewGitLogLine" ) &&
  git checkout $(echo "$commit" | sed "s/ .*//")
}
alias zco=zgitco
# zgitcb - git commit browser with previews
zgitcb() {
    glNoGraph |
        fzf --preview-window=up,60%,nofollow --info=inline \
            --no-sort --reverse --tiebreak=index --no-multi \
            --ansi --preview="$_viewGitLogLine" \
                --header "enter to view, alt-y to copy hash" \
                --bind "enter:execute:$_viewGitLogLine   | D" \
                --bind "alt-y:execute:$_gitLogLineToHash | xclip"
}
alias zcb=zgitcb
# zgitcl - git commit browser
zgitlog() {
  git --no-pager log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --info=inline \
      --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % ; read') << 'FZF-EOF'
                {}
FZF-EOF"
}
alias zcl=zgitlog
# zgitstash - easier way to deal with stashes
# type zgitstash to get a list of your stashes
# enter shows you the contents of the stash
# ctrl-d shows a diff of the stash against your current HEAD
# ctrl-b checks the stash out as a branch, for easier merging
zgitstash() {
  local out q k sha
  while out=$(
    git stash list --pretty="%C(yellow)%h %>(14)%Cgreen%cr %C(blue)%gs" |
    fzf --ansi --no-sort --query="$q" --print-query \
        --expect=ctrl-d,ctrl-b);
  do
    mapfile -t out <<< "$out"
    q="${out[0]}"
    k="${out[1]}"
    sha="${out[-1]}"
    sha="${sha%% *}"
    [[ -z "$sha" ]] && continue
    if [[ "$k" == 'ctrl-d' ]]; then
      git diff $sha
    elif [[ "$k" == 'ctrl-b' ]]; then
      git stash branch "stash-$sha" $sha
      break;
    else
      git stash show -p $sha
    fi
  done
}
alias zst=zgitstash
zman() {
    man -k . | fzf -q "$1" --prompt='man> '  \
      | awk -F\( '{print $1}' | xargs -r man
}
#source $HOME/.local/src/zsh-interactive-cd/zsh-interactive-cd.plugin.zsh
#
# FZF functions #########################
#
#eval $( gdircolors -b $HOME/.LS_COLORS )
# this is a bit slow.
#fm6000 -c random -w -de="Amethyst" -pa $(ls -l $HOMEBREW_CELLAR|wc -l) -g 3
#
# https://github.com/jarun/nnn/wiki/
export NNN_OPTS="deHUeEDrRx"
export NNN_PLUG='f:finder;o:fzopen;m:mocplay;d:diffs;v:imgview;j:autojump;k:bookmarks;z:fzz;u:getplugs;x:hexview;t:imagethumb;i:ipinfo;l:launch;b:nbak;p:pdfview'
alias n3=nnn
## OneDark
#BLK="04" CHR="04" DIR="04" EXE="00" REG="00" HARDLINK="00" SYMLINK="06" MISSING="00" ORPHAN="01" FIFO="0F" SOCK="0F" OTHER="02"
#export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"
## Nord
#BLK="0B" CHR="0B" DIR="04" EXE="06" REG="00" HARDLINK="06" SYMLINK="06" MISSING="00" ORPHAN="09" FIFO="06" SOCK="0B" OTHER="06"
#export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"
#
#(cat ~/.cache/wal/sequences &)
# themes:
# wal --theme supernova -nte
# wal --theme neonhive -nte
# wal --theme vadar -nte
#=> wal --theme matrix -nte
# wal --theme dna -nte
# wal --theme topology -nte
# wal --theme neon -nte
# wal --theme stars -nte
# wal --theme breakingbad -nte
# wal --theme robotgirl -nte
# wal --theme skullove -nte
# wal --theme car3 -nte
# wal --theme car2 -nte
# wal --theme car1 -nte
# wal --theme sunset -nte
# wal --theme austin -nte
# wal --theme casey -nte
# wal --theme vancea -nte
# wal --theme gellidon -nte
# wal --theme karsten -nte
# wal --theme serenade -nte
# wal --theme nightkey -nte
# wal --theme hope -nte
# wal --theme creature -nte
# wal -R -n -t -w -e &
# pid=$!; disown %1; sleep 1; ( [[ $(ps -p $pid) ]] && kill -9 $pid 1>/dev/null 2>/dev/null) &>/dev/null

export LIBRARY_PATH=$LIBRARY_PATH:$HOME/homebrew/lib
#set -o vi
# These two stay the last since we need our own path to be at the top.
#bindkey -v
set -o vi
unset VISUAL
unset EDITOR
export VISUAL=v
export EDITOR=v
unalias a 2>/dev/null # was fasd -a

#### fig setup
unalias hgd 2>/dev/null
export PAGER='bat -p'
export LESS='FRX' # if PAGER == 'less'
# source /etc/bash_completion.d/hgd
alias hgco='hg update'  # checkout a specfic rev.
alias hghd='hg update p4head'  # checkout the head.
alias hgam='hg amend'   # hg modify/update the existing rev.
alias hgdf='hg diff | D'    # hg diff.
alias hgdh='hg diff -r p4head'  # diff aginst piper head.
alias hgpd='hg pdiff'  # diff aginst parent.
alias hgdd='hg diff -r p4head | D'  # diff aginst piper head.
alias hgxl='hg xl'      # hg current workspace log.
alias hgll='hg ll'      # hg log list.
alias hgup='hg sync'    # srcup current branch for hg.
alias hgua='hg sync --all && hg uploadall'    # srcup all for hg.
alias hgml='hg mail'    # hg mail for review.
alias hguc='hg amend && uc'      # upload/populate cl.
alias hgcm='hg commit'  # commit the change to local.
alias hgum='hg uncommit'  # uncommit the change from local.
alias hgsm='hg submit'  # commit the change to piper.
alias hgnx='hg next'    # rebase/reorder edited to next child.
alias hgpv='hg prev'    # rebase/reorder edited to parent rev.
alias hgrb='hg rebase'  # move rev on graph.
alias hgrc='hg rebase --continue' # continue the sync.
alias hgra='hg rebase --abort'    # abort the sync.
alias hgrs='hg rebase --stop'     # stop the sync.
alias hgst='hg status'  # same as hgs.
alias hgpl='hgxl'       # like g4 pending.
alias hgps='hg pstatus' # like g4 whatsout.
alias hgev='hg evolve --update'
alias hgre='hg resolve -l'
alias hghp='hg help'
alias hgrm='hg rm'      # remove files from piper.
alias hgrh='hg prune'   # absolute/hide a unexported rev (only commit).
alias hgrv='hg cls-drop --prune -c' # revert cl.
alias hgrf='hg revert' # revert uncommitted file.
alias hgra='hg revert --all' # revert all uncommited change. (reset --hard)
alias hgrp='hg revert -r p4base' # revert uncommited file to p4base.
alias hgrw='hg citc --delete' # remove the workspace.
alias hgun='hghd && hgua'  # checkout head and sync.
alias hgpx='hg patch'      # patch someone else's cl.
alias hgcp='hg cp'
alias hgmv='hg mv'
alias hgrg='hg grep --all' # find pattern in rev.
alias hgwd='hg reword'    # change cl desc.
alias hgfx='hg fix'
alias hgnh='hg status -u' # g4 nothave
alias hgls='hg ll -f'
alias hgla='hg log -vf'

xd() {
    inputdir=$1
    curdir=$PWD
    target=${curdir##*google3/}

    if [[ $target == $curdir ]]; then
        # we are at google3 root, so
        # no additional work needed.
        hgd $inputdir
        return
    fi

    hgdir=${inputdir%%@*}
    afterdir=${inputdir##*@}
    if [[ $afterdir == '.' ]]; then
        hgd $hgdir && cd $target
    fi
}
#### fig setup

#### MacPorts setup
export PATH=$PATH:/opt/local/bin:/opt/local/sbin
export MANPATH=/opt/local/share/man:$MANPATH
alias pt='sudo /opt/local/bin/port'
alias ptsp='pt -v selfupdate'
alias ptup='pt upgrade'
alias ptuo='ptup outdated'
alias ptif='pt info'
alias ptfd='pt search'
alias ptcl='pt clean --all'
alias ptis='pt -v install'
alias ptus='pt uninstall'
alias ptua='pt uninstall --follow-dependents'
alias ptuf='pt -f uninstall'
alias ptct='pt --size contents'
alias ptls='pt -v installed'
alias ptdp='pt dependents'
alias ptvr='pt variants'
#### MacPorts setup

export PATH=$HOME/bin:$HOME/go_code/bin:$PATH:$HOME/go/bin:$HOME/homebrew/opt/util-linux/bin:$HOME/homebrew/opt/util-linux/sbin
export CORP_HOME=/usr/local/google/home/jimxu
# Just in case.

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/miniforge3/etc/profile.d/conda.sh" ]; then
        . "$HOME/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
unalias sux
# <<< conda initialize <<<



# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/jimxu/Downloads/gcloud/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/jimxu/Downloads/gcloud/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/jimxu/Downloads/gcloud/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/jimxu/Downloads/gcloud/google-cloud-sdk/completion.zsh.inc'; fi

#wal --theme serenade -nte

# Source the Lazyman shell initialization for aliases and nvims selector
# shellcheck source=.config/nvim-Lazyman/.lazymanrc
[ -f ~/.config/nvim-Lazyman/.lazymanrc ] && source ~/.config/nvim-Lazyman/.lazymanrc
# Source the Lazyman .nvimsbind for nvims key binding
# shellcheck source=.config/nvim-Lazyman/.nvimsbind
[ -f ~/.config/nvim-Lazyman/.nvimsbind ] && source ~/.config/nvim-Lazyman/.nvimsbind
# Bob neovim version manager path
[ -d ${HOME}/.local/share/bob/nvim-bin ] && {
  export PATH="${HOME}/.local/share/bob/nvim-bin${PATH:+:${PATH}}"
}
alias zm='lazyman'
unalias ls
alias ls='exa -a --sort=modified --icons --git --color=always'

source ~/.kube.zsh
