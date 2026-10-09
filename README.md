<img src="https://i.postimg.cc/KzF4W0W5/livebian-logo.png"
       width="100"
       height="100">
</img>
# Livebian

Livebian is a Linux distribution based on [Debian GNU/Linux 13 (trixie)](https://www.debian.org/releases/trixie/) Live, but this distribution **DOES NOT contain an installer**.

## Why?

Livebian is designed for PCs that don't have an internal drive (such as an HDD, SSD, NVMe drive, or eMMC storage). It runs directly from external or removable media, including:

* CD-ROM
* USB drive
* SD card
* Portable HDD or SSD

## Variants

Livebian has eight variants:

| Desktop Environment                                                          | Status                             |
| ---------------------------------------------------------------------------- | ---------------------------------- |
| [Xfce](https://www.xfce.org/)                                                | **Default · Recommended · Tested** |
| [LXQt](https://lxqt-project.org/)                                            | Tested                             |
| [GNOME](https://www.gnome.org/)                                              | Tested                             |
| [KDE Plasma](https://kde.org/plasma-desktop/)                                | Tested                             |
| [Cinnamon](https://en.wikipedia.org/wiki/Cinnamon_%28desktop_environment%29) | Unbuilt                            |
| [MATE](https://mate-desktop.org/)                                            | Unbuilt                            |
| [COSMIC](https://system76.com/cosmic)                                        | Unbuilt                            |
| Minimal (TTY, no desktop environment)                                        | Tested                             |

## Project Details

* **Last Built:** Thursday, October 8, 2026, 12:00:26 PM EEST
* **Last Updated:** Friday, October 9, 2026, 10:40:51 AM EEST
* **Build System:** [live-build](https://manpages.debian.org/testing/live-build/live-build.7.en.html)
* **live-build Version:** `20250505+deb13u1`
* **Base System:** [Debian GNU/Linux 13 (trixie)](https://www.debian.org/releases/trixie/)

### ISOs Created

1. `livebian-console-amd64.iso`
2. `livebian-xfce-amd64.hybrid.iso`
3. `livebian-lxqt-amd64.hybrid.iso`
4. `livebian-gnome-amd64.hybrid.iso`
5. `livebian-kde-amd64.hybrid.iso`

### `/etc/os-release`

```ini
PRETTY_NAME="Livebian GNU/Linux 13 (trixie)"
NAME="Livebian"
ID=livebian
ID_LIKE=debian
VERSION_ID="13"
VERSION="13 (trixie)"
VERSION_CODENAME=trixie
CODENAME=trixie
LOGO=livebian
```
To get the ISO, please go to the <a href="https://sites.google.com/view/livebian/downloads">Downloads Page</a>
