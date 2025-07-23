#!/bin/bash

set -e

# Force Debian 11 source list for Debian 12 compatibility
distribution=debian11

echo "Removing old NVIDIA source list (if exists)..."
sudo rm -f /etc/apt/sources.list.d/nvidia-container-toolkit.list

echo "Adding NVIDIA GPG key..."
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | \
  sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg

echo "Adding NVIDIA Container Toolkit repo for $distribution..."
curl -fsSL https://nvidia.github.io/libnvidia-container/${distribution}/libnvidia-container.list | \
  sed 's|^deb |deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] |' | \
  sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list > /dev/null

echo "Updating APT and installing nvidia-container-toolkit..."
sudo apt-get update
sudo apt-get install -y nvidia-container-toolkit

echo "Restarting Docker..."
sudo systemctl restart docker

echo "✅ NVIDIA Container Toolkit installed successfully!"

