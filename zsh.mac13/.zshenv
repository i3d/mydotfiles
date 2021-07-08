unalias zz 2>/dev/null
unalias vi 2>/dev/null
unalias v 2>/dev/null
unalias g  2>/dev/null # alias to git which never good.
unalias rd 2>/dev/null # for mac remote desktop, not rmdir
unalias cp 2>/dev/null # don't ask.
unalias a 2>/dev/null # was fasd -a
unalias hgd 2>/dev/null
unalias vi 2>/dev/null
unalias v 2>/dev/null
unalias g  2>/dev/null # alias to git which never good.
unalias rd 2>/dev/null # for mac remote desktop, not rmdir
unalias fd 2>/dev/null # don't alias to find -t f

alias dfa='df -ha .'
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
alias python=$HOME/homebrew/bin/python3
alias x='xplr'
alias hbc='~/bin/hbc.sh'
alias g4='p4'
alias bbbb='blaze'
alias vim='nv -u ~/.vimrc -X -O'
alias v='vim'
alias zshrc="v ~/.zshrc ~/.zshrc.pre-oh-my-zsh"
alias ohmyzsh="v ~/.oh-my-zsh"
alias va='v ~/.vimrc ~/.vimrc.plug'
alias v1='v ~/.vimrc'
alias v2='v ~/.vimrc.plug'
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
alias xcd=zx
alias his=zh
alias glNoGraph='git --no-pager log --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr% C(auto)%an" "$@"'
alias zco=zgitco
alias zcb=zgitcb
alias zcl=zgitlog
alias zst=zgitstash
alias n3=nnn
alias brup='brew upgrade'
alias bris='brew install'
alias brus='brew uninstall'
alias brif='brew info'
alias brcs='brew cleanup -s'
alias brdo='brew doctor'
alias brfd='brew search'
alias dupp='doom sync -up'

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

alias sux='ssh -t -A -X ujimux.c.googlers.com'
alias dstat='dstat -cdlmnpsy'
alias tl='tmux ls'
alias tlc='tmux lsc'
alias tc='tmux list-commands'
alias tw='tmux list-windows -t'
alias sr='screen -UraAd'
alias tk='tmux kill-session -t'
alias srx='screen -UraAdx'
alias srr='screen -UaADRR'
alias sk='screen_kill'
alias s='echo $STY'
alias sdg='screen -c /home/jimxu/.screenrc-go -d -m -UaA -S go'
alias sg='screen -c /home/jimxu/.screenrc-go -UaA -S go'
alias sde='screen -c /home/jimxu/.screenrc-everything -d -m -UaA -S everything'
alias se='screen -c /home/jimxu/.screenrc-everything -UaA -S everything'
alias sdc='screen -c /home/jimxu/.screenrc-compile -d -m -UaA -S compile'
alias sc='screen -c /home/jimxu/.screenrc-compile -UaA -S compile'
alias sdj='screen -c /home/jimxu/.screenrc-jotspot -d -m -UaA -S jotspot'
alias sj='screen -c /home/jimxu/.screenrc-jotspot -UaA -S jotspot'
alias sdb='screen -c /home/jimxu/.screenrc-borg -d -m -UaA -S borg'
alias sb='screen -c /home/jimxu/.screenrc-borg -UaA -S borg'
alias cdgocode='cd ~/go_code/src/'
alias gtags='/home/build/nonconf/google3/tools/tags/gtags.sh'
alias gtagsc='/home/build/nonconf/google3/tools/tags/gtags.sh --lang=c++'
alias gtagsj='/home/build/nonconf/google3/tools/tags/gtags.sh --lang=java'
alias gtagsjs='/home/build/nonconf/google3/tools/tags/gtags.sh --lang=javascript'
alias gtagspb='/home/build/nonconf/google3/tools/tags/gtags.sh --lang=proto'
alias gtagspy='/home/build/nonconf/google3/tools/tags/gtags.sh --lang=python'
alias vless='vi -u /usr/share/vim/vim80/macros/less.vim'
alias bls='/bin/ls -trABipFG'
alias ls='exa -aBFG --sort=type --icons --time=modified --git --color=always'
alias l='ls -Hlghi --sort=modified --group-directories-first'
alias lsd='l -D'
alias md='mkdir -p'
alias info_cal='ssh caladmin exec /etc/cron.d/scripts/add_events2 --info-calendars'
alias dump_group='ssh caladmin /usr/local/bin/list_domain_calendars.par --calendar_type group'
alias dump_user='ssh caladmin /usr/local/bin/list_domain_calendars.par --calendar_type user'
alias dump_res='ssh caladmin /usr/local/bin/list_domain_calendars.par --calendar_type resource'
alias cdcorpcron='cd /home/build/ops/corp/slack/roles/caladmin/files.cron/etc/cron.d/scripts'
alias cdsp='cd /home/jimxu/src/sp/google3/experimental/users/jimxu/sp'
alias cdexp='cd /home/jimxu/src/google3_experimental/google3/experimental/users/jimxu/'
alias cddjango='cd /home/build/google3/third_party/py/django/v0_96'
alias cdconfman='cd /home/jimxu/src/google3-confman/google3/'
alias cdconfmant='cd /home/jimxu/src/confman_turbogears/depot/google3/experimental/users/jimxu/confman_turbogears/confman'
alias cddasherman2='cd ~/src/dasherman2/google3'
alias cddasherman='cd ~/src/dasherman/depot/ops/corp/slack/roles/dasherman/files/usr/local/lib/dasherman'
alias cddclient='cd ~/src/dasherman-client/depot/ops/corp/dogfood/dasherman-client/'
alias cdshuttle='/home/jimxu/src/andriod/shuttle/google3/experimental/android/Shuttle/src/com/google/android/shuttle'
alias smartsync='/home/build/nonconf/google3/tools/continuous_build/smartsync.sh'
alias smartsyncdoozer='smartsync -l DOOZER'
alias cdcdb='cd ~/src/corpdb/google3/google3/ops/sysops/corpdb/'
alias cdacr='cd ~/src/acr/ops/corp/acr'
alias cdesc='cd ~/src/ops_esc/'
alias cdmgxp='cd ~/src/mg_agent_xp/'
alias cdgoogle3mgxp='cd ~/src/google3_mgxp/google3/'
alias cddocs='cd ~/src/designdocs/'
alias cdapps='cd ~/src/google3_docs_borg/google3/production/'
alias cdjotsre='cd ~/src/jotspot-sre/google3'
alias cdjot='cd ~/src/jotspot/google3/java/com/google/jotspot/'
alias cdbase='cd ~/src/google3_base/google3/base'
alias cdnet='cd ~/src/google3_net/google3/net/'
alias cdjavabase='cd ~/src/google3_java/google3/java/com/google/common'
alias cdjavanet='cd ~/src/google3_java/google3/java/com/google/net'
alias cdgslb='cd ~/src/gslb/google3/googledata/production/gslbpush/sources'
alias cdpushqr='cd ~/src/push_qr/google3/production/tools/push_quickrelease'
alias cdgfe='cd /home/jimxu/src/gfe/google/config'
alias cdlab='cd ~/src/codelabs/'
alias build='bbbb build'
alias cdg4='cd ~/src/google3_g4/branches/google3_tools_dev_branch/google3'
alias btest='bbbb test'
alias cdblaze='cd ~/src/google3_blaze/google3'
alias cdblazelib='cd ~/src/google3_blaze/google3/java/com/google/devtools/build/lib'
alias ss='cd ../../'
alias srcup='g4 sync'
alias g4p='g4 p'
alias g4s='g4 submit'
alias g4c='g4 change'
alias openglibc='w3m http://www.gnu.org/software/libc/manual/html_mono/libc.html#toc_Top'
alias openman='w3m http://linux.die.net/man/'
alias openman1='w3m http://linux.die.net/man/1/'
alias openman2='w3m http://www.kernel.org/doc/man-pages/index.html'
alias openman3='w3m http://linux.die.net/man/3/'
alias openman4='w3m http://linux.die.net/man/4/'
alias openman5='w3m http://linux.die.net/man/5/'
alias openman6='w3m http://linux.die.net/man/6/'
alias openman7='w3m http://linux.die.net/man/7/'
alias openman8='w3m http://linux.die.net/man/8/'
alias openmanl='w3m http://linux.die.net/man/l/'
alias openmann='w3m http://linux.die.net/man/n/'
alias openglxr='w3m http://fiasco.mtv.corp.google.com/lxr/http/source/'
alias opengkernel='w3m http://fiasco.mtv.corp.google.com/lxr/http/source/'
alias openlxr='w3m http://lxr.linux.no/'
alias openjava='w3m https://wiki.corp.google.com/twiki/bin/view/Main/Java'
alias opensj='w3m https://www.corp.google.com/~engdocs/nonconf/java/common/overview-summ#'
alias opengdb='w3m http://sourceware.org/gdb/current/onlinedocs/gdb/'
alias opensyscall='w3m http://www.win.tue.nl/~aeb/linux/lk/lk-4.html'
alias opensyscalls='w3m http://www.kernel.org/doc/man-pages/online/pages/man2/syscalls.2.html'
alias openautoconf='w3m http://www.gnu.org/software/autoconf/manual/autoconf.html'
alias openautomake='w3m http://sources.redhat.com/automake/automake.html'
alias opengcc='w3m http://www.network-theory.co.uk/docs/gccintro/index.html'
alias opengccman='w3m http://gcc.gnu.org/onlinedocs/'
alias opencstd='w3m http://c0x.coding-guidelines.com/index.html'
alias opencfaq='w3m http://c-faq.com/questions.html'
alias opencplusfaq='w3m http://www.parashift.com/c++-faq-lite/'
alias openccfaq='w3m http://www2.research.att.com/~bs/bs_faq2.html#void-main'
alias opencheaders='w3m http://en.wikipedia.org/wiki/Category:C_standard_library_headers'
alias opencposix='w3m http://en.wikipedia.org/wiki/C_POSIX_library'
alias opensus4='w3m http://pubs.opengroup.org/onlinepubs/9699919799/mindex.html'
alias openw3m='w3m http://w3m.sourceforge.net/MANUAL'
alias jade='/google/data/ro/teams/jade/jade'
alias lk='CGSession -suspend'
alias common='sort ~/.histfile | uniq -c | sort -n -r | head -n10'
alias shck='shellcheck -s sh'
alias yl="yamllint -d \"rules: {line-length: disable}\""
alias ls2="find . -type d -mindepth 1 -maxdepth 1 ! -path '*app' -exec basename {} \;"
alias wgetimg="wget -nd -H -r -l 2 -A jpg"
