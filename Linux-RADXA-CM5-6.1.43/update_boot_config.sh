#!/bin/bash

# Backup existing config
cp /boot/extlinux/extlinux.conf /boot/extlinux/extlinux.conf.bak
echo "Backed up /boot/extlinux/extlinux.conf to /boot/extlinux/extlinux.conf.bak"

# Define the new entry
NEW_ENTRY='
label linux-6.1.43-patched
    kernel /boot/Image
    initrd /boot/initramfs-linux.img
    fdt /boot/dtbs/linux-aarch64-rockchip-bsp6.1-joshua-git/rockchip/rk3588s-radxa-cm5-io.dtb
    fdtoverlays /boot/dtbs/rockchip/overlays/axp20x.dtbo /boot/dtbs/rockchip/overlays/cwu50_panel.dtbo /boot/dtbs/rockchip/overlays/displaystuff.dtbo
    append root=UUID=b6416d3c-ad04-4289-a5d1-8c02070ba8a1 earlycon=uart8250,mmio32,0xfeb50000 console=ttyFIQ0 console=tty1 consoleblank=0 loglevel=0 panic=10 rootwait rw init=/sbin/init rootfstype=ext4 cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory swapaccount=1 irqchip.gicv3_pseudo_nmi=0 switolb=1 coherent_pool=2M
'

# Prepend the new entry to the existing file (keeping the old one as fallback)
echo "$NEW_ENTRY" | cat - /boot/extlinux/extlinux.conf.bak > /boot/extlinux/extlinux.conf

echo "Updated /boot/extlinux/extlinux.conf with new kernel entry."
