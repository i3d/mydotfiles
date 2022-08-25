1.  copy the hyper file to /usr/share/X11/xkb/symbols dir.
2.  do a one-time load to make sure the file is loadable.

      ```setxkbmap -layout hyper```

      if no error is raised, then

      ```localectl --no-convert set-x11-keymap hyper```

      to make it permanent (hyper is a superset of us keyboard layout)

3.  follow [soltion 2](https://unix.stackexchange.com/questions/414926/bind-capshjkl-to-arrow-keys-caps-to-esc)
      to create .xmodmap file. (or copy the one over)

      run ```xmodmap ~/.xmodmap``` to load it.

4.  copy .profile (or the last few lines for remapping) to the home dir. it does:
      a.  autoload xmodmap.
      b.  xcape the hyper_l (capslock) to esc.

