# Path to your oh-my-zsh installation.
export ZSH=/Users/jimxu/.oh-my-zsh

source $ZSH/oh-my-zsh.sh

# for awesome-terminal-fonts
source $HOME/src/awesome-terminal-fonts/fonts/*.sh
POWERLEVEL9K_MODE='nerdfont-complete'

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
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# Example aliases
alias zshconfig="vi ~/.zshrc"
alias ohmyzsh="vi ~/.oh-my-zsh"
alias pomz="vi ~/.zshrc.pre-oh-my-zsh"

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
export PATH=/Users/jimxu/go/bin:/Users/jimxu/bin:/Users/jimxu/go_code/bin:/usr/local/bin:/usr/local/sbin:/usr/local/symlinks:/usr/local/scripts:/usr/local/buildtools/java/jdk/bin:/sw/bin:/sw/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/bin/g4bin:/usr/X11R6/bin:/Users/jimxu/pkgs/android-sdk-linux_x86-1.5_r3/tools:/Users/jimxu/src/depot_tools

PATH=$HOME/.rbenv/shims:$HOME/homebrew/bin:$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
export PATH="/Users/jimxu/homebrew/sbin:$PATH"


export CSCOPE_DB=/Users/jimxu/src/linux/cscope.out

#github qfc
[[ -s "$HOME/.qfc/bin/qfc.sh"  ]] && source "$HOME/.qfc/bin/qfc.sh"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# terminal logo
#screenfetch
neofetch
# don't fatch the IP.
#archey -o

export PATH=$HOME/bin:$PATH

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

### Added by Zplugin's installer
source '/Users/jimxu/.zplugin/bin/zplugin.zsh'
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin's installer chunk

###
zplugin load zdharma/history-search-multi-word

zplugin ice compile"*.lzui" from"notabug"
zplugin load zdharma/zui

# One other binary release, it needs renaming from `docker-compose-Linux-x86_64`.
# This is done by ice-mod `mv'{from} -> {to}'. There are multiple packages per
# single version, for OS X, Linux and Windows – so ice-mod `bpick' is used to
# select Linux package – in this case this is not needed, Zplugin will grep
# operating system name and architecture automatically when there's no `bpick'

zplugin ice from"gh-r" as"program" mv"docker* -> docker-compose" bpick"*linux*"; zplugin load docker/compose

# Scripts that are built at install (there's single default make target, "install",
# and it constructs scripts by `cat'ing a few files). The make"" ice could also be:
# `make"install PREFIX=$ZPFX"`, if "install" wouldn't be the only, default target

zplugin ice as"program" pick"$ZPFX/bin/git-*" make"PREFIX=$ZPFX"
zplugin light tj/git-extras

# Two regular plugins loaded in default way (no `zplugin ice ...` modifiers)

zplugin light zsh-users/zsh-autosuggestions
zplugin light zdharma/fast-syntax-highlighting
zplugin light zsh-users/zsh-syntax-highlighting

zplugin ice atclone"gdircolors -b LS_COLORS > c.zsh" atpull'%atclone' pick"c.zsh" nocompile'!'
zplugin light trapd00r/LS_COLORS

# This one to be ran just once, in interactive session

#zplugin ice as"program" make'!' atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' src"zhook.zsh"
#zplugin light direnv/direnv
#

setopt promptsubst


zplugin creinstall %HOME/my_completions  # Handle completions without loading any plugin, see "clist" command
# function issue. some highlight permission denied issue.
#zplugin light trapd00r/zsh-syntax-highlighting-filetypes
zplg light unixorn/tumult.plugin.zsh

# After zplugin, override the prompt

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

# for oni finding neovim
export ONI_NEOVIM_PATH=/Users/jimxu/homebrew/bin/nvim

# space vim, not using neovim due to deoplete-go.
alias vv='vi -u ~/.SpaceVim/vimrc'
# make sure any override of vim alias to homebrew's version (the version I use)
#alias vim='~/bin/vim -u ~/.vimrc -X -p'
alias vim='nv -u ~/.vimrc -X -p'
alias vi='vim'
alias v='vi'

# cause trouble, must at the end of .zshrc
#source /Users/jimxu/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/Users/jimxu/homebrew/share/zsh-syntax-highlighting/highlighters
#
# currently using the following zsh prompt themes. either generate one from using vim promptline plguin,
# or use zplugin powerlevel9k, both works, or fallback to a fixed liquidprompt.
# having git_prompt_status issue
#source ~/.liquidprompt/liquidprompt
#source ~/.promptline.sh
# ==== load OMZ theme ====
# Load OMZ Git library
zplugin snippet OMZ::lib/git.zsh

# Load Git plugin from OMZ
zplugin snippet OMZ::plugins/git/git.plugin.zsh
zplugin cdclear -q # <- forget completions provided up to this moment
#
#zplugin snippet OMZ::themes/cloud.zsh-theme
#zplugin snippet OMZ::themes/cypher.zsh-theme
#zplugin snippet OMZ::themes/kolo.zsh-theme
#zplugin snippet OMZ::themes/lambda.zsh-theme
#zplugin snippet OMZ::themes/lukerandall.zsh-theme
#zplugin snippet OMZ::themes/mikeh.zsh-theme
#zplugin snippet OMZ::themes/miloshadzic.zsh-theme
#zplugin snippet OMZ::themes/muse.zsh-theme
#zplugin snippet OMZ::themes/nicoulaj.zsh-theme
#zplugin snippet OMZ::themes/norm.zsh-theme
#zplugin snippet OMZ::themes/obraun.zsh-theme
#zplugin snippet OMZ::themes/afowler.zsh-theme
# having issues.
#zplugin light NicoSantangelo/Alpharized
#
# ==== load 3rd_party theme ====
#
# Load theme from github directly.
# Load the pure theme, with zsh-async library that's bundled with it
# use our own theme
#zplugin ice pick"async.zsh" src"pure.zsh"; zplugin light sindresorhus/pure
#
#zplugin light tannhuber/oh-my-zsh-budspencer
#
zplugin light denysdovhan/spaceship-prompt
SPACESHIP_BATTERY_SHOW=false
#
#zplugin light halfo/lambda-mod-zsh-theme
#
# nice but ugly in vim term.
#zplugin light bhilburn/powerlevel9k
#zplugin light romkatv/powerlevel10k
#
# prompt_git:15: unknown group
#zplugin light caiogondim/bullet-train.zsh
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
export PATH=/Users/jimxu/bin:/Users/jimxu/.cargo/bin:/Users/jimxu/src/Nim/bin:$PATH
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

source $HOME/src/dotfiles/zsh/prompt.sh
export PATH=$PATH:$HOME/src/dotfiles/utils

#unset ZSH_ENV
# load the vim file manager if we aren't already in vifm
# when vifmrc loaded, it will set this env to true.
[[ -z ${VIFM_ENABLED} ]] && vifm

HOMEBREW_PREFIX=/Users/jimxu/homebrew
eval $(${HOMEBREW_PREFIX}/bin/brew shellenv)

# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
(cat ~/.cache/wal/sequences &)
# To add support for TTYs this line can be optionally added.
#source ~/.cache/wal/colors-tty.sh
export PATH=$PATH:$HOME/.emacs.d/bin
wal -R

#fish
unalias s
