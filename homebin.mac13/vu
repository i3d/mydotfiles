#!/bin/bash

main() {
  echo "Update vim ... "
  cd ~/.vim
  git pull 1>/dev/null

  echo -e "\nUpdate bundles ... \n"

  cd ~/.vim/bundle/

  for dir in $(ls -d *); do
  echo -n "Update bundle ${dir//\//} ... "
  (cd $dir; git pull) >/dev/null
  echo "done"
  done
}

main
exit 0
