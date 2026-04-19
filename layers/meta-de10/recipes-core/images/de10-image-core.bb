SUMMARY = "DE10-Nano core image with SSH and DHCP"
DESCRIPTION = "Minimal image for the DE10-Nano with OpenSSH server and \
systemd-networkd DHCP so the board is reachable over the network \
immediately after boot."

inherit core-image

IMAGE_FEATURES += "ssh-server-openssh"

IMAGE_INSTALL:append = " \
    de10-network-config \
    gdbserver \
    nano \
    de10-fpga \
"
