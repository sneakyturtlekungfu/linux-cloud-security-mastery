# Brave Icon / Desktop Launcher Fix (RHEL 10)

**Date:** 2025-11-23  
**System:** RHEL 10 + GNOME + Brave (RPM)

## Problem
After installing Brave on RHEL, the GNOME launcher icon was missing and showing a generic placeholder. The desktop entry pointed to an icon name that did not exist in `/usr/share/pixmaps`.

## Root Cause
Brave installs its icons under:

```
/opt/brave.com/brave/product_logo_128.png
/opt/brave.com/brave/product_logo_64.png
```

But GNOME expects icons under `/usr/share/pixmaps` or `/usr/share/icons`.

## Fix

### 1. Find Brave’s installed PNG icons:
```bash
rpm -ql brave-browser | grep -i png
```

### 2. Copy a proper PNG to the system icon directory:
```bash
sudo cp /opt/brave.com/brave/product_logo_128.png \
        /usr/share/pixmaps/brave-browser.png
```

### 3. Edit the desktop entry:
```bash
sudo nano /usr/share/applications/brave-browser.desktop
```

Ensure:

```
Icon=brave-browser
```

### 4. Refresh icons (optional):
```bash
sudo gtk-update-icon-cache -f /usr/share/icons/hicolor
```

## Verification
- GNOME now shows the correct Brave icon
- The dock shows the correct icon
- The icon persists after reboot

## Notes
This demonstrates:
- package file inspection (`rpm -ql`)
- understanding of `.desktop` files
- fixing icon lookup path issues
