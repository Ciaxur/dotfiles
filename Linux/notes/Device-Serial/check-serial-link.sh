# List the USB Devices
lsusb

# Note the ID Number
# Get the Product ID That a tty device linked to
grep PRODUCT= /sys/bus/usb-serial/devices/ttyUSB0/../uevent


# Check demsg for Activities
sudo dmesg | grep tty
