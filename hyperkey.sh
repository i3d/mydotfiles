#!/bin/bash

if ! `ps -ef|grep xcape |grep -v grep >/dev/null`; then
    echo "setup hyperkey ..."
    # set up key mapping.
    # 1. hyper_l + hjkl for arrows.
    xmodmap $HOME/.xmodmap
    # 2. hyper_l self == esc
    # NOTE: this command has a quirk: if you run two times,
    # reset the behavior back. so it can only really run
    # once per login.
    # ssh session reads .zprofile, so if we put this in .zprofile
    # then whether a given session will have this enabled or not
    # becomes unpredicable.
    xcape -e 'Mode_switch=Escape'
fi
