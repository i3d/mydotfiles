# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi

# Path to your oh-my-zsh installation.
export ZSH=/Users/jimxu/.oh-my-zsh

source $ZSH/oh-my-zsh.sh

# for awesome-terminal-fonts
source $HOME/src/awesome-terminal-fonts/fonts/*.sh
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

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
#plugins=(git rails textmate ruby lighthourse osx gdoc pip python screen themes history vi-mode go golang github brew mercurial tmux)
plugins=(safe-paste rails textmate lighthourse osx gdoc pip python screen themes history vi-mode go golang mercurial tmux github brew betterbrew autoupdate zsh-iterm-touchbar)

source ~/.zshrc.pre-oh-my-zsh
[[ -f $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm


# Customize to your needs...
export PATH=/usr/local/bin:/usr/local/sbin:/usr/local/symlinks:/usr/local/scripts:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/bin/g4bin:/usr/X11R6/bin:/Users/jimxu/pkgs/android-sdk-linux_x86-1.5_r3/tools:/usr/local/google/bin:/Users/jimxu/src/depot_tools
export CSCOPE_DB=/Users/jimxu/src/linux/cscope.out

# Initialize HOMEBREW PATHs and ENVs before we add our own.
HOMEBREW_PREFIX=/Users/jimxu/homebrew
eval $(${HOMEBREW_PREFIX}/bin/brew shellenv)

export PATH=/Users/jimxu/homebrew/opt/llvm/bin:$PATH:$HOME/.rvm/bin:/$HOME/.rbenv/shims # Add RVM to PATH for scripting

#github qfc
[[ -s "$HOME/.qfc/bin/qfc.sh"  ]] && source "$HOME/.qfc/bin/qfc.sh"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if `which rg &>/dev/null`; then
    #export FZF_DEFAULT_COMMAND='rg --hidden -l ""'
    export FZF_DEFAULT_COMMAND='rg -S --trim --column -H --hidden ""'
else
    # if nothing else, this is the default.
    export FZF_DEFAULT_COMMAND='find .'
fi

# for my kir workstation.
#. $HOME/.bagpipe/setup.sh $HOME/.bagpipe jimxu-linux.kir.corp.google.com "corp-ssh-helper --stderrthreshold=INFO %h %p"
# for my c.googler.com instance.
. $HOME/.bagpipe/setup.sh $HOME/.bagpipe ujimux.c.googlers.com "corp-ssh-helper -relay=sup-ssh-relay.corp.google.com --stderrthreshold=INFO %h %p"
#. $HOME/.bagpipe/setup.sh $HOME/.bagpipe ujimux.c.googlers.com
#


function renew_gcert_ifneeded() {
  HOURS_TILL_EOB=$((20 - $(date +%-H)))h
  #gcertstatus -ssh_cert_comment=corp/normal -check_remaining=$HOURS_TILL_EOB || gcert
  gcertstatus -ssh_cert_comment=corp/normal -check_remaining=$HOURS_TILL_EOB || ~/bin/pa.py
}

function renew_bagpipe_ifneeded() {
  p4 info > /dev/null 2>&1 || (gcert --nounruffled="not ready" && p4 bagpipe-prodaccess)
}

function pa() {
  renew_gcert_ifneeded
  # open up our first connection to our remote host so that any
  # disconnection will be reconnected. 'then sux wouldn't bother
  # manual reconnect anymore'
  echo "ssh to ujimux.c.googler.com ..."
  echo
  renew_bagpipe_ifneeded
  # idempotent if already connected.
  # help any remote editing or opened remote sessions, e.g. sux, remote tmux, vscode, oni, etc.
  #autossh -f -M20000 -t -A -X ujimux.c.googlers.com
}

#too slow on laptop.
#pa

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

#[ -f /Users/jimxu/homebrew/opt/fzf/shell/completion.zsh ] &&  source /Users/jimxu/homebrew/opt/fzf/shell/completion.zsh
#[ -f /Users/jimxu/homebrew/opt/fzf/shell/key-bindings.zsh ] &&  source /Users/jimxu/homebrew/opt/fzf/shell/key-bindings.zsh

#BASE16_SHELL="$HOME/.config/base16-shell/"
#[ -n "$PS1" ] && \
#    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
#        eval "$("$BASE16_SHELL/profile_helper.sh")"
#
#source /Users/jimxu/homebrew/share/antigen/antigen.zsh
source /Users/jimxu/.zprezto/init.zsh

### Added by zinit's installer
source ~/.zinit/bin/zinit.zsh
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of zinit's installer chunk

###
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

zinit light zsh-users/zsh-autosuggestions
zinit light zdharma/fast-syntax-highlighting
zinit light zsh-users/zsh-syntax-highlighting

zinit ice atclone"gdircolors -b LS_COLORS > c.zsh" atpull'%atclone' pick"c.zsh" nocompile'!'
zinit light trapd00r/LS_COLORS

# This one to be ran just once, in interactive session

#zinit ice as"program" make'!' atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' src"zhook.zsh"
#zinit light direnv/direnv
#

setopt promptsubst


zinit creinstall %HOME/my_completions  # Handle completions without loading any plugin, see "clist" command
# function issue. some highlight permission denied issue.
#zinit light trapd00r/zsh-syntax-highlighting-filetypes
zplg light unixorn/tumult.plugin.zsh

# 4/24/2021 fzf utilities
zinit load wfxr/forgit
zinit light kazhala/dotbare

# After zinit, override the prompt

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

[ -f /Users/jimxu/homebrew/etc/profile.d/autojump.sh ] && . /Users/jimxu/homebrew/etc/profile.d/autojump.sh

# if use homebrew go

# node.js, nvm
export NVM_DIR="$HOME/.nvm"
[ -s "${HOME}/homebrew/opt/nvm/nvm.sh" ] && . "${HOME}/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "${HOME}/homebrew/opt/nvm/etc/bash_completion" ] && . "${HOME}/homebrew/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

#homebrew cleanup previous installs.
export HOMEBREW_INSTALL_CLEANUP=1
#or run this to cleanup.
alias hbc='~/bin/hbc.sh'
alias g4='p4'
alias bbbb='blaze'
# g4d citc stuff.
source /Library/GoogleCorpSupport/srcfs/shell_completion/enable_completion.sh

#export CPLUS_INCLUDE_PATH=/Users/jimxu/homebrew/Cellar/gcc/HEAD-2d3af38/include/c++/9.0.1:/usr/include:/usr/local/include:$HOME/.local/include:$CPLUS_INCLUDE_PATH
# for oni finding neovim
export ONI_NEOVIM_PATH=/Users/jimxu/homebrew/bin/nvim

# edit the vimrc.
alias vim='nv -u ~/.vimrc -X -p'
alias v='vim'
alias zshrc="v -O ~/.zshrc ~/.zshrc.pre-oh-my-zsh"
alias ohmyzsh="v ~/.oh-my-zsh"
alias va='v -O ~/.vimrc ~/.vimrc.plug'
alias v1='v -O ~/.vimrc'
alias v2='v -O ~/.vimrc.plug'
alias vz='zshrc'
alias z1='v -O ~/.zshrc'
alias z2='v -O ~/.zshrc.pre-oh-my-zsh'
alias vcheat='v $HOME/bin/cheat'
# make sure any override of vim alias to homebrew's version (the version I use)
#alias vim='~/bin/vim -u ~/.vimrc -X -p'
# v always == vim
#alias vi='vim'
# vi can be emacs, or vim
# no alias, it is a ln -sf to ~/bin/e
#alias vi='~/bin/e'

# cause trouble, must at the end of .zshrc
#source /Users/jimxu/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/Users/jimxu/homebrew/share/zsh-syntax-highlighting/highlighters
#
# currently using the following zsh prompt themes. either generate one from using vim promptline plguin,
# or use zinit powerlevel9k, both works, or fallback to a fixed liquidprompt.
# having git_prompt_status issue
#source ~/.liquidprompt/liquidprompt
#source ~/.promptline.sh
# ==== load OMZ theme ====
# Load OMZ Git library
zinit snippet OMZ::lib/git.zsh

# Load Git plugin from OMZ
zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit cdclear -q # <- forget completions provided up to this moment
#
# having issues.
#zinit light NicoSantangelo/Alpharized
#
# ==== load 3rd_party theme ====
#
# Load theme from github directly.
# Load the pure theme, with zsh-async library that's bundled with it
# use our own theme
#
#zinit light tannhuber/oh-my-zsh-budspencer
#
# ============ was enabled before =======================
#zinit light denysdovhan/spaceship-prompt
#SPACESHIP_BATTERY_SHOW=false
#
#
# nice but ugly in vim term.
#zinit light bhilburn/powerlevel9k
#
# ========== Current prompt ===================
# Disable for starship
# zinit light romkatv/powerlevel10k
#
# prompt_git:15: unknown group
#zinit light caiogondim/bullet-train.zsh
#BULLETTRAIN_STATUS_EXIT_SHOW=true

fpath+=~/.zfunc
eval "$(hub alias -s)"

# Base16 Shell
# some color did changes, seems better, the original is also very good.
# both can try.
#BASE16_SHELL="$HOME/src/vim-hybrid-material/base16-material/base16-material.dark.sh"
#[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL
#
BASE16_SHELL="$HOME/src/base16-shell/"
[ -n "$PS1" ] && \
[ -s "$BASE16_SHELL/profile_helper.sh" ] && \
eval "$("$BASE16_SHELL/profile_helper.sh")"

. /Users/jimxu/homebrew/opt/asdf/asdf.sh
. /Users/jimxu/homebrew/opt/asdf/etc/bash_completion.d/asdf.bash
#
# always make sure my own bin path is the first
export PATH=/Users/jimxu/.cargo/bin:/Users/jimxu/src/Nim/bin:$PATH
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

# parth/dotfiles
export VISUAL=vim
stty -ixon
source $HOME/src/dotfiles/zsh/keybindings.sh

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
#source $HOME/src/dotfiles/zsh/prompt.sh
#export PATH=$PATH:$HOME/src/dotfiles/utils

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
#
# bat has ln and syntax highlight.
alias cat='bat -pp'
alias less='bat -p'
# always unalias vi
unalias vi 2>/dev/null
unalias v 2>/dev/null
unalias g  2>/dev/null # alias to git which never good.
unalias rd 2>/dev/null # for mac remote desktop, not rmdir
#export PATH=$HOME/.config/nvim/utils/bin:$HOME/bin:$PATH
fortune | cowsay -f $(cowsay -l| sed '1d' | shuf | tr ' ' '\n' | head -1) | lolcat
# see https://unix.stackexchange.com/questions/140750/generate-random-numbers-in-specific-range
# or jot -r 1 1 10000
# head -200 /dev/urandom | cksum
#
cbonsai -s $(shuf -i 1-10000 -n 1) -p
# terminal logo
#screenfetch
#neofetch
afetch
# don't fatch the IP.
#archey -o

#unset ZSH_ENV
# load the vim file manager if we aren't already in vifm
# when vifmrc loaded, it will set this env to true.
#[[ -z ${VIFM_ENABLED} ]] && vf .

killwal() {
    sleep 3
    if ps -ef|grep $1 &>/dev/null; then
      kill -9 $1 &>/dev/null
    fi
}

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
zinit ice pick"async.zsh" src"pure.zsh"; zinit light sindresorhus/pure

export PATH=$PATH:$HOME/.config/nvcode/utils/bin
# Setup python environment. It should be on >= v3
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
alias python=$HOME/homebrew/bin/python3

# neovim as man pager.
export MANPAGER="/bin/sh -c \"col -b | v -c 'set ft=man ts=8 nomod nolist noma nu' -\""

#### FZF thems ######
# serenade
export FZF_DEFAULT_OPTS="--color=bg+:#3B4346,bg:#2A2F33,gutter:#2A2F33,spinner:#c1bf89,hl:#C76767,fg:#bfddb2,header:#CC9361,info:#87c095,pointer:#82abbc,marker:#c1bf89,fg+:#D49864,prompt:#e5a46b,hl+:#87c095 --header-lines=0 --ansi --keep-right --info=inline"

# molokai
#export FZF_DEFAULT_OPTS='--color=bg+:#293739,bg:#1B1D1E,border:#808080,spinner:#E6DB74,hl:#7E8E91,fg:#F8F8F2,header:#7E8E91,info:#A6E22E,pointer:#A6E22E,marker:#F92672,fg+:#F8F8F2,prompt:#F92672,hl+:#F92672'
#
# gruvbox
#export FZF_DEFAULT_OPTS="--color=bg+:#1B1D1E,bg:#1B1D1E,spinner:#fb4934,hl:#928374,fg:#ebdbb2,header:#928374,info:#8ec07c,pointer:#fb4934,marker:#fb4934,fg+:#ebdbb2,prompt:#fb4934,hl+:#fb4934"

#### FZF thems ######
#### FZF customized key bindings ####
bindkey -v
bindkey -M viins '^x' fzf-history-widget # r for reverse history search
bindkey -M viins '^f' fzf-file-widget # f for file
bindkey -M viins '^j' fzf-cd-widget # j for jump
bindkey -M viins '^t' transpose-chars # t for transpose
bindkey -M viins '\ec' capitalize-word # c for capitalizae
#### FZF customized key bindings ####
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
# command history
zh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -E 's/ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g')
}
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
_viewGitLogLine="$_gitLogLineToHash | xargs -I % sh -c 'git --no-pager show --color=always % | delta -n -s'"

# zgitco - checkout git commit with previews
zgitco() {
  local commit
  commit=$( glNoGraph |
    fzf --preview-window=up,60%,nofollow --info=inline \
        --no-sort --reverse --tiebreak=index --no-multi \
        --ansi --preview="$_viewGitLogLine" ) &&
  git checkout $(echo "$commit" | sed "s/ .*//")
}
# zgitcb - git commit browser with previews
zgitcb() {
    glNoGraph |
        fzf --preview-window=up,60%,nofollow --info=inline \
            --no-sort --reverse --tiebreak=index --no-multi \
            --ansi --preview="$_viewGitLogLine" \
                --header "enter to view, alt-y to copy hash" \
                --bind "enter:execute:$_viewGitLogLine   | delta -n -s" \
                --bind "alt-y:execute:$_gitLogLineToHash | xclip"
}
# zgitcl - git commit browser
zgitlog() {
  git --no-pager log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --info=inline \
      --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | delta -n -s') << 'FZF-EOF'
                {}
FZF-EOF"
}
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
zman() {
    man -k . | fzf -q "$1" --prompt='man> '  \
      | awk -F\( '{print $1}' | xargs -r man
}
source $HOME/src/zsh-interactive-cd/zsh-interactive-cd.plugin.zsh
# FZF functions #########################
#
#eval $( gdircolors -b $HOME/.LS_COLORS )
# These two stay the last since we need our own path to be at the top.
export PATH=/Users/jimxu/bin:/Users/jimxu/go_code/bin:$PATH:/Users/jimxu/go/bin
# this is a bit slow.
#fm6000 -c random -w -de="Amethyst" -pa $(ls -l $HOMEBREW_CELLAR|wc -l) -g 3
# put this at the end since it could hang.
# TODO: figure out why.
# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
(cat ~/.cache/wal/sequences &)
wal -R -n -t -w -e &
#killwal $! &
