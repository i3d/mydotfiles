## lua build issue

Mac for some reason has a broken gunzip. The lua packages that need to be built can't be gunzipped correctly. So this fix needs to be applied while the building starts.

### Do this under the src tree.

1. copy the tools.lua to the /tmp dir.
2. kick off the build with make diskclean && make ....
3. after .deps has been cleaned up, issue this command
   `while :; do [[ -f .deps/usr/share/lua/5.1/luarocks/fs/unix/tools.lua ]] && cp /tmp/tools.lua .deps/usr/share/lua/5.1/luarocks/fs/unix/ && break; done`

   it will wait for the luarocks to be built and files populated and then it will replace the tools.lua to this patched version.
