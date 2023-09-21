#vim
/configure --prefix=$HOME/.local --enable-python3interp --without-x --enable-luainterp --with-features=big --enable-terminal --disable-xsmp --enable-gui --with-python3-command=$HOME/homebrew/bin/python3 && make && make install

#neovim
make distclean && make CMAKE_EXTRA_FLAGS=-DCMAKE_INSTALL_PREFIX=$HOME/.local CMAKE_BUILD_TYPE=Release


#vifm
./configure --prefix=$HOME/.local --without-X11 && make && make install
