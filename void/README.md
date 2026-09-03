```sh
sudo xbps-install git curl
curl https://mise.run | sh

DOTS=$HOME/Projects/github.com/stellarhoof/dots
git clone https://github.com/stellarhoof/dots.git $DOTS
~/.local/bin/mise bootstrap --yes --skip-dirty --cd $DOTS/common
~/.local/bin/mise bootstrap --yes --skip-dirty --cd $DOTS/void

echo "repository=https://repo.voiders.dev" | sudo tee /etc/xbps.d/10-voiders-community.conf
sudo xbps-install -S
sudo xbps-install noctalia noctalia-greeter

sudo ln -s /etc/sv/greetd /var/service
```

# Battery life

## Framework forums

- https://knowledgebase.frame.work/framework-system-on-linux-a-tool-to-monitor-configure-and-update-framework-laptop-hardware-HJbak1uRel
  - https://github.com/FrameworkComputer/framework-system

- https://community.frame.work/t/tracking-linux-battery-life-tuning/6665
  - Measure average power draw during different workloads, using `powertop` and `powerstat`.

## Arch wiki

https://wiki.archlinux.org/title/Power_management

- https://wiki.archlinux.org/title/Framework_Laptop_13_(AMD_Ryzen_7040_Series)#Power_management
  - https://wiki.archlinux.org/title/Framework_Laptop_13#(AMD)_TLP_is_not_advised_for_power_management._PPD_is_recommended
  - https://wiki.archlinux.org/title/Framework_Laptop_13#(AMD)_Washed-out_colors_when_using_power-profiles-daemon_in_power-saver_or_balanced_mode

## My notes

- Optimize idle and sleep (hibernate on lid close instead of sleep?)
- Check whether I've got latest BIOS/kernel
- auto-cpufreq?
- Variable display refresh rate?
- Check whether video hardware decoding is on (browser's hdw acceleration)
- kernel 6.5 amd-pstate?
