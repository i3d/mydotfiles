###### !!!! VIM mode forever !!!! ########
###### !!!! VIM mode forever !!!! ########
###### !!!! VIM mode forever !!!! ########
bindkey -v
autoload -z edit-command-line
zle -N edit-command-line
[[ ! -d $HOME/.local/src/zsh-vimode-visual ]] && \
  cd $HOME/.local/src && \
  git clone https://github.com/b4b4r07/zsh-vimode-visual.git
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
export ZSH=/home/jimxu/.oh-my-zsh
###### !!!! VIM mode forever !!!! ########
###### !!!! VIM mode forever !!!! ########
###### !!!! VIM mode forever !!!! ########
#
# ================ Before sourcing OMZ ====================
CASE_SENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
ZSH_THEME="archcraft"
plugins=(z jump cargo rust colorize command-not-found common-aliases copybuffer cp dircycle dirhistory dotenv iterm2 safe-paste osx pip python themes history vi-mode golang mercurial github brew betterbrew autoupdate git)

export PATH=/usr/local/bin:/usr/local/sbin:/usr/local/symlinks:/usr/local/scripts:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/bin/g4bin:/usr/X11R6/bin:/home/jimxu/pkgs/android-sdk-linux_x86-1.5_r3/tools:/usr/local/google/bin:/home/jimxu/src/depot_tools
export CSCOPE_DB=/home/jimxu/src/linux/cscope.out
# ================ Before sourcing OMZ ====================

#### !!!! All ENV variables setup needed for OMZ and pre-oh-my-zsh ENDs here !!!! #######
source $ZSH/oh-my-zsh.sh
source ~/.zshrc.pre-oh-my-zsh
#### !!!! All ENV variables setup needed for OMZ and pre-oh-my-zsh ENDs here !!!! #######
[[ -f $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm



# Initialize HOMEBREW PATHs and ENVs before we add our own.
HOMEBREW_PREFIX=/home/linuxbrew/.linuxbrew
NEED_INSTALL_BREW=0
if [[ ! -d $HOMEBREW_PREFIX ]]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    NEED_INSTALL_BREW=1
fi
export HOMEBREW_INSTALL_CLEANUP=1
eval $(${HOMEBREW_PREFIX}/bin/brew shellenv)

# this will take a while
if ((  $NEED_INSTALL_BREW )); then
  # first install build tools
  echo "Install build tools ..."
  brew install \
    wget yarn node ipython && \
  # install core tools
  echo "Install core tools ..."
  brew install \
    hub asdf autojump fasd fd tldr the_silver_searcher \
    zsh-syntax-highlighting glow source-highlight && \
  echo "Install secondary tools ..."
  # if the above all went well, then install secondary tools
  brew install \
    colormake colortail cowsay cppcheck cppman \
    cscope ctags ctail diffutils direnv fortune \
    go gotop htop lolcat lsof ncdu multitail neofetch \
    nnn pcre pcre2 peco pidof pstree ranger shellcheck shfmt \
    ssh-copy-id tree-sitter && \
  # everything went well, continue installing 
  echo "Install network tools ..."
  brew install \
    fping geoip hping ifstat iftop iperf mtr nmap speedtest-cli tping \
    tcptraceroute w3m && \
  # continue installing media apps
  echo "Install media apps ..."
  brew install \
    ffmpeg ffmpeg-iina flac imagemagick media-info mpv mplayershell \
    transmission-cli youtube-dl && \
  echo "Install other apps ..."
  brew install \
    util-linux typescript universal-ctags mark-text qutebrowser 

  echo "Install node tools ..."
  if [[ ! $(npm updatge -g --force && npm install -g neovim flake8) ]] ; then
    yarn update && yarn instal -g neovim flake8
  fi
fi

export PATH=/home/linuxbrew/.linuxbrew/opt/llvm/bin:$PATH:$HOME/.rvm/bin:/$HOME/.rbenv/shims # Add RVM to PATH for scripting

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
fi

[[ ! -d $HOME/src/ytfzf ]] && \
  cd $HOME/src && \
  git clone https://github.com/pystardust/ytfzf.git && \
  cp $HOME/src/ytfzf/ytfzf $HOME/.local/bin
# ytfzf config
export YTFZF_PLAYER="mpv --vd-queue-enable=yes --vd-lavc-threads=4"

if [[ ! -d $HOME/src/neovim ]]; then
  echo "Install neoview.git ..."
  cd $HOME/src
  git clone https://github.com/neovim/neovim.git
  cd neovim
  make distclean && make CMAKE_EXTRA_FLAGS=-DCMAKE_INSTALL_PREFIX=$HOME/.local CMAKE_BUILD_TYPE=Release
  make install
fi

#github qfc
[[ -s "$HOME/.qfc/bin/qfc.sh"  ]] && source "$HOME/.qfc/bin/qfc.sh"
##### !!!! Start plugin managers !!!! ######
##### !!!! Start plugin managers !!!! ######
### Added by zinit's installer
if [[ ! -d ~/.zinit ]];then
  mkdir -p ~/.zinit
  git clone https://github.com/zdharma/zinit.git ~/.zinit/bin
fi
source ~/.zinit/bin/zinit.zsh
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of zinit's installer chunk
#
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

#autoload -Uz history-beginning-search-menu-space-end history-beginning-search-menu
#zle -N history-beginning-search-menu-space-end history-beginning-search-menu
#bindkey "^H" history-beginning-search-menu-space-end
zmodload -i zsh/parameter
#insert-last-command-output() {
#  LBUFFER+="$(eval $history[$((HISTCMD-1))])"
#}
#zle -N insert-last-command-output
#bindkey "^Q" insert-last-command-output
#autoload -Uz compinit
#compinit

setopt list_rows_first
setopt glob_complete
setopt histignoredups
setopt ignoreeof
unsetopt flowcontrol
setopt correct_all
setopt promptsubst

autoload -U colors && colors
export SPROMPT="Correct $fg_bold[red]%R$reset_color to $fg_bold[green]%r?$reset_color ($fg_bold[green]Yes$reset_color, $fg_bold[yellow]No$reset_color, $fg_bold[red]Abort$reset_color, $fg_bold[blue]Edit$reset_color) "
###############################

###
zinit load zdharma/history-search-multi-word
zinit ice compile"*.lzui" from"notabug"
zinit load zdharma/zui
zinit ice from"gh-r" as"program" mv"docker* -> docker-compose" bpick"*linux*"; zinit load docker/compose
zinit ice as"program" pick"$ZPFX/bin/git-*" make"PREFIX=$ZPFX"
zinit light tj/git-extras
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma/fast-syntax-highlighting
zinit light zsh-users/zsh-syntax-highlighting
zinit ice atclone"gdircolors -b LS_COLORS > c.zsh" atpull'%atclone' pick"c.zsh" nocompile'!'
zinit light trapd00r/LS_COLORS
zinit creinstall %HOME/my_completions  # Handle completions without loading any plugin, see "clist" command
zplg light unixorn/tumult.plugin.zsh
zinit load wfxr/forgit
zinit light kazhala/dotbare
zinit snippet OMZ::lib/git.zsh
zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit cdclear -q # <- forget completions provided up to this moment
#
#### After zinit, load zplug.
export ZPLUG_HOME=$HOME/.zplug
if [[ ! -d $ZPLUG_HOME ]]; then
  git clone https://github.com/zplug/zplug $ZPLUG_HOME
fi
source $HOME/.zplug/init.zsh
zplug "marlonrichert/zsh-autocomplete"
zplug "zsh-users/zsh-history-substring-search"
# ###### ==== plugins ====== #####
# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
# config plugins before it is loaded.
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
# config plugins before it is loaded.
#
# Then, source plugins and add commands to $PATH
zplug load --verbose
# have to be after the plugin loaded.
HISTORY_SUBSTRING_SEARCH_FUZZY=1
#### After zinit, load zplug.
source $HOME/.local/src/zsh-interactive-cd/zsh-interactive-cd.plugin.zsh

[ -f /home/linuxbrew/.linuxbrew/etc/profile.d/autojump.sh ] && . /home/linuxbrew/.linuxbrew/etc/profile.d/autojump.sh

# node.js, nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh" ] && . "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion" ] && . "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

[[ ! $(which xplr) ]] && brew install --head xplr && mkdir -p $HOME/.config/xplr
alias x='xplr'
alias hbc='~/bin/hbc.sh'
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
alias python=/home/linuxbrew/.linuxbrew/bin/python3
alias cat='bat -pp'
alias less='bat -p'
unalias vi 2>/dev/null
unalias v 2>/dev/null
unalias g  2>/dev/null # alias to git which never good.
unalias rd 2>/dev/null # for mac remote desktop, not rmdir

fpath+=~/.zfunc
eval "$(hub alias -s)"

[[ ! -d $HOME/.local/src/base16-shell ]] && \
  mkdir -p $HOME/.local/src && \
  cd $HOME/.local/src && \
  git clone https://github.com/chriskempson/base16-shell.git
BASE16_SHELL="$HOME/src/base16-shell/"
[ -n "$PS1" ] && \
[ -s "$BASE16_SHELL/profile_helper.sh" ] && \
eval "$("$BASE16_SHELL/profile_helper.sh")"

[[ -f /home/linuxbrew/.linuxbrew/opt/asdf/asdf.sh ]] && \
    . /home/linuxbrew/.linuxbrew/opt/asdf/asdf.sh
[[ -f /home/linuxbrew/.linuxbrew/opt/asdf/etc/bash_completion.d/asdf.bash ]] && \
    . /home/linuxbrew/.linuxbrew/opt/asdf/etc/bash_completion.d/asdf.bash
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
export PATH=/home/jimxu/.cargo/bin:/home/jimxu/src/Nim/bin:$PATH
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
if [[ "$(command -v fasd)" && ! -f "$fasd_cache" ]]; then
    fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install >| "$fasd_cache"
fi
[[ -f "$fasd_cache" ]] && source "$fasd_cache"
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

fortune | cowsay -f $(cowsay -l| sed '1d' | shuf | tr ' ' '\n' | head -1) | lolcat
# see https://unix.stackexchange.com/questions/140750/generate-random-numbers-in-specific-range
# or jot -r 1 1 10000
# head -200 /dev/urandom | cksum
afetch

export PATH=$PATH:$HOME/.config/nvcode/utils/bin
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
# https://github.com/jarun/nnn/wiki/
export NNN_OPTS="deHUeEDrRx"
export NNN_PLUG='f:finder;o:fzopen;m:mocplay;d:diffs;v:imgview;j:autojump;k:bookmarks;z:fzz;u:getplugs;x:hexview;t:imagethumb;i:ipinfo;l:launch;b:nbak;p:pdfview'
alias n3=nnn
export PATH=/home/jimxu/bin:/home/jimxu/go_code/bin:$PATH:/home/jimxu/go/bin
unset VISUAL
unset EDITOR
export VISUAL=v
export EDITOR=v
