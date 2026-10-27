#!/bin/bash

# NOTE: Don't select any service after installing the base image
# NOTE: Run this script as root

# Update xbps
xbps-install -yu xbps

# Add repository for non-free packages
xbps-install -y void-repo-nonfree

# Add repository for noctalia
echo "repository=https://repo.voiders.dev" >/etc/xbps.d/10-voiders-community.conf

# Synchronize remote repository index files and update system
xbps-install -Syu

# Missing:
# - tailwindcss-language-server
# - worktrunk
# - git-get
xbps-install -y \
  7zip \
  ast-grep \
  bind-utils \
  brave-browser \
  curl \
  ddcutil \
  delta \
  dua-cli \
  duf \
  elogind \
  eza \
  fd \
  fish-shell \
  font-firacode \
  foot \
  framework-system \
  fwupd \
  fzf \
  git \
  git-filter-repo \
  git-lfs \
  github-cli \
  gnupg \
  gopass \
  greetd \
  htop \
  hub \
  libatomic \
  mesa \
  mesa-vaapi \
  mise \
  moor \
  mpv \
  nerd-fonts-symbols-ttf \
  niri \
  noctalia \
  noto-fonts-emoji \
  noto-fonts-ttf \
  pass \
  pass-otp \
  pipewire \
  power-profiles-daemon \
  powertop \
  psmisc \
  qrencode \
  qt5-wayland \
  ripgrep \
  shfmt \
  socklog-void \
  starship \
  tokei \
  trash-cli \
  upower \
  wget \
  wl-clipboard \
  xdg-desktop-portal \
  xdg-desktop-portal-gtk \
  xtools \
  yt-dlp \
  iwd \
  zoxide \
  kmscon \
  turnstile \
  rtkit \
  bluez \
  libspa-bluetooth \
  wireless-regdb \
  xwayland-satellite \
  bibata-modern-ice

# https://www.marcusfolkesson.se/blog/linux-wireless-regulatory/

# Grants processes higher scheduling priority when competing with other threads (e.x. audio will be given priority over browser threads).
# See https://www.linuxdj.com/notes/pipewire-real-time-scheduling-in-2026-rtkit-portal-and-rlimits/

# Install kmscon runit services to `/etc/sv` since the kmscon package does not include them.
cp -R ./etc/sv/kmscon-generic /etc/sv
for vt in {8..8}; do
  dir=/etc/sv/kmscon-tty$vt
  mkdir -p $dir/log
  ln -sf ../kmscon-generic/run $dir/
  ln -sf ../kmscon-generic/finish $dir/
  ln -sf ../kmscon-generic/conf $dir/
  ln -sf ../../kmscon-generic/log/run $dir/log/
  ln -sf /run/runit/supervise.kmscon-tty$vt $dir/supervise
  ln -sf /run/runit/supervise.kmscon-tty$vt-log $dir/log/supervise
done

# Services

# Synchronizes system clock with NTP servers
ln -s /etc/sv/chronyd /var/service/
# System logger
ln -s /etc/sv/socklog-unix /var/service/
ln -s /etc/sv/nanoklogd /var/service/
# Power profiles daemon
ln -s /etc/sv/power-profiles-daemon /var/service/
# System dbus
ln -s /etc/sv/dbus /var/service
# Login manager
ln -s /etc/sv/greetd /var/service/
# WiFi connection manager
ln -s /etc/sv/iwd /var/service
# Bluetooth manager
ln -s /etc/sv/bluetoothd /var/service
# Per user services manager
ln -s /etc/sv/turnstiled /var/service

# Use kmscon on tty6 and leave other TTYs untouched in case kmscon doesn't start properly
rm /var/service/agetty-tty8
ln -s /etc/sv/kmscon-tty8 /var/service

# Connect to the internet
# iwctl station wlp1s0 connect [SSID]

# Update man pages
makewhatis /usr/share/man

# Reboot machine since the kernel was probably updated.
reboot now
