```sh
# After installing the base image, enable the following services
# - dhcpcd: DHCP (Dynamic Host Configuration Protocol) daemon. Needed to automatically assign an IP address and other connection details to devices.
# - wpa_supplicant: WPA (Wi-Fi Protected Access) management. Scanning, selection, and authentication. It will be replaced by iwd after boot.
# - chronyd: Synchronizes system clock with NTP servers.

# Update xbps
sudo xbps-install -yu xbps

# Add repository for non-free packages
sudo xbps-install -y void-repo-nonfree

# Add repository for noctalia
echo "repository=https://repo.voiders.dev" | sudo tee /etc/xbps.d/10-voiders-community.conf

# Synchronize remote repository index files and update system
sudo xbps-install -Syu

# Reboot machine since the kernel was probably updated.
sudo reboot now

# Install mise and other required software
# - git and curl are required by mise
# - libatomic is required by nodejs
# - gpg and pass are required for post-setup
sudo xbps-install -y mise git curl libatomic gnupg pass

# Activate mise
eval "$(mise activate bash)"

export DOTS=$HOME/Projects/github.com/stellarhoof/dots
git clone https://github.com/stellarhoof/dots.git $DOTS
mise bootstrap --yes --skip-dirty --cd $DOTS/common
mise bootstrap --yes --skip-dirty --cd $DOTS/void

# Enable system logger daemon
sudo ln -s /etc/sv/socklog-unix /var/service/
sudo ln -s /etc/sv/nanoklogd /var/service/

# Enable power profiles daemon
sudo ln -s /etc/sv/power-profiles-daemon /var/service/

# Enable the system dbus, an IPC mechanism for userspace software.
sudo ln -s /etc/sv/dbus /var/service

# Enable login manager daemon
sudo ln -s /etc/sv/greetd /var/service/

# Allow user to read system logs without sudo
sudo usermod -a -G socklog ah
```

# Tips

Parameters passed to the kernel during boot: `cat /proc/cmdline`
Configure kernel parameters at runtime: `sysctl`
Add kernel parameters for next boot: modify `GRUB_CMDLINE_LINUX_DEFAULT` in `/etc/default/grub`
Show status of kernel modules: `lsmod`
Add and remove modules from the kernel: `modprobe`
Inspect system logs: `svlogtail [service]`

# Resources

https://animeshz.github.io/site/blogs/void-linux.html

# Battery life

## Framework forums

- https://knowledgebase.frame.work/framework-system-on-linux-a-tool-to-monitor-configure-and-update-framework-laptop-hardware-HJbak1uRel
  - https://github.com/FrameworkComputer/framework-system

- https://community.frame.work/t/tracking-linux-battery-life-tuning/6665
  - Measure average power draw during different workloads, using `powertop` and `powerstat`.

- https://community.frame.work/t/guide-fw13-ryzen-power-management/42988

## Arch wiki

https://wiki.archlinux.org/title/Power_management

- https://wiki.archlinux.org/title/Framework_Laptop_13_(AMD_Ryzen_7040_Series)#Power_management
  - https://wiki.archlinux.org/title/Framework_Laptop_13#(AMD)_TLP_is_not_advised_for_power_management._PPD_is_recommended
  - https://wiki.archlinux.org/title/Framework_Laptop_13#(AMD)_Washed-out_colors_when_using_power-profiles-daemon_in_power-saver_or_balanced_mode

- https://wiki.archlinux.org/title/Power_management

## My notes

- Optimize idle and sleep (hibernate on lid close instead of sleep?)
- Check whether I've got latest BIOS/kernel
- auto-cpufreq?
- Variable display refresh rate?
- Check whether video hardware decoding is on (browser's hdw acceleration)
- kernel 6.5 amd-pstate?
