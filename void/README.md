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
