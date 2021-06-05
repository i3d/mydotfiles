###### !!!! VIM mode forever !!!! ########
###### !!!! VIM mode forever !!!! ########
###### !!!! VIM mode forever !!!! ########
bindkey -v
autoload -z edit-command-line
zle -N edit-command-line
[[ ! -d $HOME/.local/src/zsh-vimode-visual ]] && \
  cd $HOME/.local/src && \
  git clone https://github.com/b4b4r07/zsh-vimode-visual.git && cd $HOME
source $HOME/.local/src/zsh-vimode-visual/zsh-vimode-visual.zsh
# neovim as man pager.
export MANPAGER="/bin/sh -c \"col -b | v -c 'set ft=man ts=8 nomod nolist noma nu' -\""
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
export ZSH=/Users/i3dmaster/.oh-my-zsh
###### !!!! VIM mode forever !!!! ########
###### !!!! VIM mode forever !!!! ########
###### !!!! VIM mode forever !!!! ########

# ================ Before sourcing OMZ ====================
ZSH_THEME="archcraft"
plugins=(z jump cargo rust colorize command-not-found common-aliases copybuffer cp dircycle dirhistory dotenv iterm2 safe-paste osx pip python themes history vi-mode golang mercurial github brew betterbrew autoupdate git)
CASE_SENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
# ================ Before sourcing OMZ ====================
source $ZSH/oh-my-zsh.sh
source ~/.zshrc.pre-oh-my-zsh
[[ -f $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm

# Customize to your needs...
export PATH=/usr/local/bin:/usr/local/sbin:/usr/local/symlinks:/usr/local/scripts:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/bin/g4bin:/usr/X11R6/bin:/Users/i3dmaster/pkgs/android-sdk-linux_x86-1.5_r3/tools:/usr/local/google/bin:/Users/i3dmaster/src/depot_tools
export CSCOPE_DB=/Users/i3dmaster/src/linux/cscope.out

# Initialize HOMEBREW PATHs and ENVs before we add our own.
export HOMEBREW_INSTALL_CLEANUP=1
HOMEBREW_PREFIX=/Users/i3dmaster/homebrew
eval $(${HOMEBREW_PREFIX}/bin/brew shellenv)

export PATH=/Users/i3dmaster/homebrew/opt/llvm/bin:$PATH:$HOME/.rvm/bin:/$HOME/.rbenv/shims # Add RVM to PATH for scripting

#github qfc
[[ -s "$HOME/.qfc/bin/qfc.sh"  ]] && source "$HOME/.qfc/bin/qfc.sh"
[[ ! -f $HOME/.fzf.zsh ]] && brew install fzf && /Users/i3dmaster/homebrew/opt/fzf/install
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if `which rg &>/dev/null`; then
    #export FZF_DEFAULT_COMMAND='rg --hidden -l ""'
    export FZF_DEFAULT_COMMAND='rg -S --trim --column -H --hidden ""'
else
    # if nothing else, this is the default.
    export FZF_DEFAULT_COMMAND='find .'
fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

if [[ ! -d $HOME/src ]]; then
  mkdir -p $HOME/src
  cd $HOME/src # non startup dependencies.
  git clone https://github.com/vifm/vifm.git && \
    cd $HOME/src/vifm && \
    configure --prefix=$HOME/.local && \
    make && make install
  git clone https://github.com/nim-lang/Nim.git
  git clone https://github.com/rust-lang/rust.git
  git clone https://github.com/golang/go.git 
  cd $HOME
fi

[[ ! -d "${ZDOTDIR:-$HOME}/.zprezto" ]] && \
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
source ${ZDOTDIR:-$HOME}/.zprezto/init.zsh

### Added by zinit's installer
if [[ ! -d ~/.zinit ]];then
  mkdir ~/.zinit
  git clone https://github.com/zdharma/zinit.git ~/.zinit/bin
fi
source ~/.zinit/bin/zinit.zsh
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of zinit's installer chunk

###
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
autoload -U colors && colors
export SPROMPT="Correct $fg_bold[red]%R$reset_color to $fg_bold[green]%r?$reset_color ($fg_bold[green]Yes$reset_color, $fg_bold[yellow]No$reset_color, $fg_bold[red]Abort$reset_color, $fg_bold[blue]Edit$reset_color) "
setopt list_rows_first glob_complete histignoredups ignoreeof promptsubst
unsetopt flowcontrol
setopt correct_all

##############################################
zinit load zdharma/history-search-multi-word

zinit ice compile"*.lzui" from"notabug"
zinit load zdharma/zui
zinit ice from"gh-r" as"program" mv"docker* -> docker-compose" bpick"*linux*"; zinit load docker/compose
zinit ice as"program" pick"$ZPFX/bin/git-*" make"PREFIX=$ZPFX"
zinit light tj/git-extras

ZSH_AUTOSUGGEST_USE_ASYNC=1
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma/fast-syntax-highlighting
zinit light zsh-users/zsh-syntax-highlighting
zinit ice atclone"gdircolors -b LS_COLORS > c.zsh" atpull'%atclone' pick"c.zsh" nocompile'!'
zinit light trapd00r/LS_COLORS
zinit creinstall %HOME/my_completions  # Handle completions without loading any plugin, see "clist" command
zplg light unixorn/tumult.plugin.zsh
zinit load wfxr/forgit
zinit light kazhala/dotbare

[ -f /Users/i3dmaster/homebrew/etc/profile.d/autojump.sh ] && . /Users/i3dmaster/homebrew/etc/profile.d/autojump.sh

# node.js, nvm
export NVM_DIR="$HOME/.nvm"
[ -s "${HOME}/homebrew/opt/nvm/nvm.sh" ] && . "${HOME}/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "${HOME}/homebrew/opt/nvm/etc/bash_completion" ] && . "${HOME}/homebrew/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

export ONI_NEOVIM_PATH=/Users/i3dmaster/homebrew/bin/nvim

[[ ! $(which xplr) ]] && brew install --head xplr && mkdir -p $HOME/.config/xplr
#homebrew cleanup previous installs.
#or run this to cleanup.
alias x='xplr'
#or run this to cleanup.
alias hbc='~/bin/hbc.sh'
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
# ==== load OMZ theme ====
# Load OMZ Git library
zinit snippet OMZ::lib/git.zsh
# Load Git plugin from OMZ
zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit cdclear -q # <- forget completions provided up to this moment
fpath+=~/.zfunc
eval "$(hub alias -s)"
BASE16_SHELL="$HOME/.local/src/base16-shell/"
[ -n "$PS1" ] && \
[ -s "$BASE16_SHELL/profile_helper.sh" ] && \
eval "$("$BASE16_SHELL/profile_helper.sh")"

[[ -f  /Users/i3dmaster/homebrew/opt/asdf/asdf.sh ]] && \
  . /Users/i3dmaster/homebrew/opt/asdf/asdf.sh
[[ -f  /Users/i3dmaster/homebrew/opt/asdf/etc/bash_completion.d/asdf.bash ]] && \
  . /Users/i3dmaster/homebrew/opt/asdf/etc/bash_completion.d/asdf.bash
#
# always make sure my own bin path is the first
if [[ ! -d $HOME/.cargo ]]; then
  # setup rustup.
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  source $HOME/.cargo/env
  rustup update && rustup default nightly
  # install core rust tools.
  cargo install bat ripgrep git-delta exa tokei procs dutree
fi
export PATH=/Users/i3dmaster/.cargo/bin:/Users/i3dmaster/src/Nim/bin:$PATH
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

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
#### cbonsai -s $(shuf -i 1-10000 -n 1) -p
# terminal logo
#screenfetch
neofetch
####afetch
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

POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

[[ ! -d $HOME/.local/src/zsh-autocomplete ]] && \
    cd $HOME/.local/src && \
    git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git && cd $HOME
[[ -f  $HOME/.local/src/zsh-autocomplete/zsh-autocomplete.plugin.zsh ]] && \
    source $HOME/.local/src/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# ###### ==== zplug plugins ====== #####
if [[ ! -d $HOME/.zplug ]]; then
    curl -sL --proto-redir -all,https \
        https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi
source ~/.zplug/init.zsh
# for some reason, this does not work in mac16 setup.
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
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
### ============ end zplug config ============= ###
# Then, source plugins and add commands to $PATH
zplug load --verbose
# after the plugin loaded.
HISTORY_SUBSTRING_SEARCH_FUZZY=1
### ============ end zplug init ============= ###
#
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
source $HOME/.local/src/zsh-interactive-cd/zsh-interactive-cd.plugin.zsh
# FZF functions #########################
#
#eval $( gdircolors -b $HOME/.LS_COLORS )
# These two stay the last since we need our own path to be at the top.
export PATH=/Users/i3dmaster/bin:/Users/i3dmaster/go_code/bin:$PATH:/Users/i3dmaster/go/bin
export NNN_OPTS="deHUeEDrRx"
export NNN_PLUG='f:finder;o:fzopen;m:mocplay;d:diffs;v:imgview;j:autojump;k:bookmarks;z:fzz;u:getplugs;x:hexview;t:imagethumb;i:ipinfo;l:launch;b:nbak;p:pdfview'
alias n3=nnn
# this is a bit slow.
#fm6000 -c random -w -de="Amethyst" -pa $(ls -l $HOMEBREW_CELLAR|wc -l) -g 3
# put this at the end since it could hang.
# TODO: figure out why.
# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
(cat ~/.cache/wal/sequences &)
#wal -R -n -t -w -e &
# themes:
# wal --theme supernova -nte
# wal --theme neonhive -nte
# wal --theme vadar -nte
# wal --theme matrix -nte
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
wal --theme creature -nte
#killwal $! &
export EDITOR=v
export VISUAL=v
export PATH=/Users/i3dmaster/bin:/Users/i3dmaster/go_code/bin:$PATH:/Users/i3dmaster/go/bin:/Users/i3dmaster/homebrew/opt/util-linux/bin:/Users/i3dmaster/homebrew/opt/util-linux/sbin
