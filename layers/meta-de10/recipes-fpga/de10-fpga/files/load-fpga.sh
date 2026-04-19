#!/bin/sh
# load-fpga: Configure DE10-Nano FPGA fabric from HPS via Linux FPGA Manager.
# Requires: configfs support, /lib/firmware/fpga.rbf and /lib/firmware/fpga.dtbo

set -e

OVERLAY_DIR=/sys/kernel/config/device-tree/overlays
OVERLAY_NAME=de10-fpga
FPGA_STATE=/sys/class/fpga_manager/fpga0/state

# Mount configfs if not already mounted
if ! mountpoint -q /sys/kernel/config 2>/dev/null; then
    mount -t configfs configfs /sys/kernel/config
fi

# Remove existing overlay cleanly before re-applying
if [ -d "${OVERLAY_DIR}/${OVERLAY_NAME}" ]; then
    rmdir "${OVERLAY_DIR}/${OVERLAY_NAME}"
fi

# Disable HPS-to-FPGA bridges before reconfiguring
for b in /sys/class/fpga_bridge/*/enable; do
    [ -e "$b" ] && echo 0 > "$b"
done

# Apply the overlay – this triggers the FPGA Manager to load fpga.rbf
mkdir "${OVERLAY_DIR}/${OVERLAY_NAME}"
echo -n fpga.dtbo > "${OVERLAY_DIR}/${OVERLAY_NAME}/path"

# Re-enable bridges
for b in /sys/class/fpga_bridge/*/enable; do
    [ -e "$b" ] && echo 1 > "$b"
done

STATUS=$(cat "${OVERLAY_DIR}/${OVERLAY_NAME}/status" 2>/dev/null || echo "unknown")
STATE=$(cat "${FPGA_STATE}" 2>/dev/null || echo "unknown")

echo "Overlay status: ${STATUS}"
echo "FPGA state:     ${STATE}"

if [ "${STATE}" = "operating" ]; then
    echo "FPGA configured successfully."
else
    echo "ERROR: FPGA did not reach 'operating' state." >&2
    exit 1
fi
