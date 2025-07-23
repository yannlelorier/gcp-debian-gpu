#!/bin/bash

set -e

echo "🖥️ Starting NVIDIA driver setup on GCP Debian instance..."

echo "📁 Enabling non-free and non-free-firmware components in sources..."

REPO_FILE="/etc/apt/sources.list.d/debian.sources"

if grep -q "^Types:.*deb" "$REPO_FILE"; then
    echo "✅ debian.sources file found, modifying it..."
    sudo sed -i 's/Components: main/Components: main non-free non-free-firmware/' "$REPO_FILE"
else
    echo "❌ Could not find $REPO_FILE — please add sources manually or check path."
    exit 1
fi

echo "📦 Updating package lists..."
sudo apt update

KERNEL_VER=$(uname -r)
echo "🧱 Installing kernel headers for: $KERNEL_VER"
sudo apt install -y linux-headers-"$KERNEL_VER"

echo "🧼 Removing legacy/conflicting NVIDIA drivers if any..."
sudo apt purge -y nvidia-current || true

echo "🚀 Installing official NVIDIA driver..."
sudo apt install -y nvidia-driver dkms

echo "🔧 Building NVIDIA kernel module via DKMS..."
sudo dkms autoinstall

echo "📦 Loading NVIDIA module..."
sudo modprobe nvidia || true

echo "Verifying NVIDIA installation..."
if command -v nvidia-smi &> /dev/null; then
    nvidia-smi || echo "⚠️ nvidia-smi found, but driver may not be active yet (reboot may be needed)."
else
    echo "❌ nvidia-smi not installed. Something went wrong."
fi

echo "✅ Done. You may want to reboot to fully activate the driver:"
echo "    sudo reboot"

