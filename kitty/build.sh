#!/bin/bash

rm -rf build
#LDFLAGS=-L/Users/jimxu/homebrew/lib arch -arm64 python3 setup.py kitty.app --extra-include-dirs ~/homebrew/Cellar/librsync/2.3.2/include
LDFLAGS=-L/Users/jimxu/homebrew/lib /Users/jimxu/homebrew/Cellar/python@3.11/3.11.0/bin/python3.11 setup.py kitty.app --extra-include-dirs ~/homebrew/Cellar/librsync/2.3.2/include -I"/Library/Developer/CommandLineTools/Library/Frameworks/Python3.framework/Versions/3.9/Headers"
