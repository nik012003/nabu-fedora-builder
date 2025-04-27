# Installation Guide (Dual boot with android on slot a)

## Step 1: Partitioning device

**NOTE**: The commands below are for a 128GB nabu, please double check them before running them, and change the sizes of the partitions accordingly. To print the partitions inside `parted` use the `print` command.

Download and boot a [custom recovery image](https://github.com/serdeliuk/xiaomi-nabu-orangefox/releases) to partition the disk.

```sh
fastboot boot xiaomi-nabu-orangefox.img 
```

Enter a shell with `adb shell` and run `parted /dev/block/sda`: 

```sh
rm 31
mkpart userdata   10.9GB 40GB
quit
```

and then `reboot` the device to make android regenerate userdata. 

Re enter fastboot and boot the recovery image

```sh
fastboot boot xiaomi-nabu-orangefox.img 
```

Enter a shell with `adb shell` and run the following

```sh
sgdisk --resize-table 64 /dev/block/sda
parted /dev/block/sda
# == Inside the parted interface ==
mkpart esp fat32 40.0GB 40.5GB
mkpart fedora ext4 40.5GB 126GB
quit 
# =================================
reboot
```

## Step 2 : Flashing

Download and extract the most recent release [here](https://github.com/nik012003/nabu-fedora-builder/releases).

Download [u-boot for nabu](https://gitlab.com/sm8150-mainline/u-boot/-/jobs).

Enter fastboot and then run the following

```
fastboot flash esp efi.img
fastboot flash fedora root.img
fastboot flash boot_b u-boot.img
fastboot flash vbmeta_b vbmeta_disabled.img
fastboot erase dtbo_b
fastboot set_active b
fastboot reboot
```

Note that commands after the flash root.img might stall for some time, since even if the command above finished, the device will still be waiting to sync data to the ufs.

## Step 3 : Have fun 

You should now see u-boot, then grub, and finally a booting linux kernel. 
The fedora image is __minimal__ , so plug in a keyboard via usb (or use the xiaomi keyboard with pogo pins) and have fun. (username: `root`, password: `fedora`). 

### Create a new user 

```sh
useradd -m your_username
# Add it to the superuser groups
usermod -aG wheel,audio,video your_username
# set a password 
passwd your_username
```

### Install a Desktop Environment

#### Gnome 
```
dnf -y install gnome-desktop4 gnome-session-wayland-session gnome-classic-session f41-backgrounds-gnome gnome-control-center gnome-panel gnome-terminal gnome-text-editor gnome-calculator gnome-calendar gnome-disk-utility gnome-font-viewer gnome-logs gnome-usage gnome-system-monitor firefox
```

#### KDE 

```
dnf group install kde-desktop-environment
```

#### Phosh 

```
dnf group install "phosh desktop"
```
