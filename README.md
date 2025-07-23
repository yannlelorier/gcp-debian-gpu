# GCP Debian GPU

For GCP Virtual Machines (or Compute Engine, as they call it), in order to use their GPU capabilities, this repository comes in handy to automate the installation of the GPU drivers.

Two main use cases:

- Installing NVIDIA GPU drivers to use on the machine on bare metal
- Installing GPU drivers for use inside of a container (Docker, for example)

# Usage

clone the repo with:

```sh
git clone git@github.com:yannlelorier/gcp-debian-gpu.git
```

cd into the folder:

```sh
cd gcp-debian-gpu
```

Make both scripts executable:

```sh
chmod +x install_cuda_drivers.sh
chmod +x nvidia_container_toolkit/install_nvidia_container_toolkit.sh
```

Simply run

```sh
./install_cuda_drivers.sh
```
and then (if necessary)
```sh
nvidia_container_toolkit/install_nvidia_container_toolkit.sh
```
