#!/bin/sh

set -e

# Create the fwup ops script to handling MicroSD/eMMC operations at runtime
# NOTE: revert.fw is the previous, more limited version of this. ops.fw is
#       backwards compatible.
mkdir -p $TARGET_DIR/usr/share/fwup
#$HOST_DIR/usr/bin/fwup -c -f $NERVES_DEFCONFIG_DIR/fwup-ops.conf -o $TARGET_DIR/usr/share/fwup/ops.fw
#ln -sf ops.fw $TARGET_DIR/usr/share/fwup/revert.fw

$HOST_DIR/bin/fdtoverlay -i $BINARIES_DIR/meson-g12a-superbird.dtb -o $BINARIES_DIR/meson-g12a-superbird-usb-gadget.dtb $BINARIES_DIR/watchdog.dtb
$HOST_DIR/bin/fdtoverlay -i $BINARIES_DIR/meson-g12a-superbird-usb-gadget.dtb -o $BINARIES_DIR/meson-g12a-superbird-usb-host.dtb $BINARIES_DIR/usb-host.dtb

# Copy the fwup includes to the images dir
cp -rf $NERVES_DEFCONFIG_DIR/fwup_include $BINARIES_DIR
