#!/bin/bash
#set -e
brew update
brew upgrade
brew cleanup -s
#brew cask cleanup
#now diagnotic
brew doctor
brew missing
brew cleanup -s
npm update -g

