# Mac OS X Lion introduced a new, iOS-like context menu when you press and hold a key
# that enables you to choose a character from a menu of options. If you are on Lion
# try it by pressing and holding down 'e' in any app that uses the default NSTextField
# for input.
#
# It's a nice feature and continues the blending of Mac OS X and iOS features. However,
# it's a nightmare to deal with in Sublime Text if you're running Vintage (Vim) mode,
# as it means you cannot press and hold h/j/k/l to move through your file. You have
# to repeatedly press the keys to navigate.

# You can disable this feature for just Sublime Text by issuing the following command
# in your terminal (*not* the Sublime Text console):

defaults write com.sublimetext.3 ApplePressAndHoldEnabled -bool false

# Note: replace com.sublimetext.3 with whichever version of Sublime Text you are running
# eg. 'com.sublimetext.2'

# Alternately, if you want this feature disabled globally, you can enter this:

defaults write -g ApplePressAndHoldEnabled -bool false

# In either case you'll need to restart Sublime Text for the change to take place.

# Happy coding!
