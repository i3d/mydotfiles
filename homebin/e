
#!/bin/bash

# randomly use different evil/vim editors on mac.
set -e

SPACE=$HOME/bin/space
DOOM="$HOME/bin/emacs -nw"
VIM='/Users/i3dmaster/bin/nvim -u ~/.vimrc -X -p'
SVIM='/Users/i3dmaster/bin/nvim -u ~/.SpaceVim/vimrc'

rnd=$(jot -r -n 19 0 9 | rs -g 0)

(($((10#$rnd%10)) > 4)) && $DOOM "$@" && exit 0     # 60%
(($((10#$rnd%10)) > 6)) && $SPACE "$@" && exit 0    # 40%
(($((10#$rnd%10)) <= 4)) && $VIM "$@" && exit 0     # 40%
(($((10#$rnd%10)) > 8)) && $SVIM "$@" && exit 0     # 20%
