#!/bin/bash
#
#
# various different mac system optimizations. mainly for programming env.

# key press repeat
defaults write -g ApplePressAndHoldEnabled -bool false
# show path in finder
defaults write com.apple.finder ShowPathbar -bool true
# key press repeat speed
defaults write NSGlobalDomain KeyRepeat -int 0.1
# wait time to kick off key repeat
defaults write NSGlobalDomain InitialKeyRepeat -int 25
# show local library
chflags nohidden ~/Library

