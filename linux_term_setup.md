```
cp term ~/linux_settings/
dconf dump '/org/gnome/'  | grep terminal
// copy that key over to replace here.
dconf load '/org/gnome/<terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/>' < ~/linux_settings/term
```
