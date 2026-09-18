#!/bin/bash

# Don't select any service after installing the base image

# Update xbps
sudo xbps-install -yu xbps

# Add repository for non-free packages
sudo xbps-install -y void-repo-nonfree

# Add repository for noctalia
echo "repository=https://repo.voiders.dev" | sudo tee /etc/xbps.d/10-voiders-community.conf

# Synchronize remote repository index files and update system
sudo xbps-install -Syu

# Missing:
# - tailwindcss-language-server
# - worktrunk
# - git-get
sudo xbps-install -y \
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
  hyprcursor \
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
  zoxide

# Services

# Synchronizes system clock with NTP servers
sudo ln -s /etc/sv/chronyd /var/service/
# System logger
sudo ln -s /etc/sv/socklog-unix /var/service/
sudo ln -s /etc/sv/nanoklogd /var/service/
# Power profiles daemon
sudo ln -s /etc/sv/power-profiles-daemon /var/service/
# System dbus
sudo ln -s /etc/sv/dbus /var/service
# Login manager
sudo ln -s /etc/sv/greetd /var/service/
# WiFi connection manager
sudo ln -s /etc/sv/iwd /var/service

# Connect to the internet
# iwctl station wlp1s0 connect [SSID]

# Update man pages
sudo makewhatis /usr/share/man

# Reboot machine since the kernel was probably updated.
sudo reboot now

# Activate mise
eval "$(mise activate bash)"

export DOTS=$HOME/Projects/github.com/stellarhoof/dots
git clone https://github.com/stellarhoof/dots.git $DOTS
mise bootstrap --yes --cd $DOTS/common
mise bootstrap --yes --cd $DOTS/void
