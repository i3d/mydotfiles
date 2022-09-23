# MAC extended filesystem (HFS+) external disk on Linux

[TOC]

source

https://superuser.com/questions/320415/mount-device-with-specific-user-rights>

```
sudo apt install hfsprogs
sudo mkdir /var/mnt
sudo mount -t hfsplus -o umask=0022,uid=<uid>,gid=<gid>,force,rw /dev/sda1 /var/mnt
sudo mkdir /var/mnt/backup_$(date)
sudo chown -R <user> /var/mnt/backup_$(date)
rsync -auvH <src> /var/mnt/backup_$(date)
cd
sudo umount /var/mnt
```
unplug and go
