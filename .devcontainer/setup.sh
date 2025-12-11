#!/bin/bash
set -e

echo "Setting up xv6 RISC-V Development Environment..."

# Update package list
echo "Updating package list..."
sudo apt-get update

# Install basic dependencies
echo "Installing dependencies..."
sudo apt-get install -y \
    git \
    build-essential \
    gdb-multiarch \
    gcc-riscv64-linux-gnu \
    binutils-riscv64-linux-gnu \
    autoconf \
    automake \
    autotools-dev \
    curl \
    libmpc-dev \
    libmpfr-dev \
    libgmp-dev \
    gawk \
    bison \
    flex \
    texinfo \
    gperf \
    libtool \
    patchutils \
    bc \
    zlib1g-dev \
    libexpat-dev \
    ninja-build \
    pkg-config \
    libglib2.0-dev \
    libpixman-1-dev \
    libsdl2-dev

# Install newer QEMU from source (need 7.2+)
echo "Installing QEMU 8.0 for RISC-V..."
if ! command -v qemu-system-riscv64 &> /dev/null || [ "$(qemu-system-riscv64 --version | grep -oP 'version \K[0-9]+\.[0-9]+' | head -1 | awk -F. '{print ($1 * 100) + $2}')" -lt 702 ]; then
    cd /tmp
    wget https://download.qemu.org/qemu-8.0.0.tar.xz
    tar xf qemu-8.0.0.tar.xz
    cd qemu-8.0.0
    ./configure --target-list=riscv64-softmmu --prefix=/usr/local
    make -j$(nproc)
    sudo make install
    cd ..
    rm -rf qemu-8.0.0 qemu-8.0.0.tar.xz
fi

# Verify QEMU version
echo "Verifying QEMU installation..."
qemu-system-riscv64 --version

# Set up RISC-V toolchain
echo "Setting up RISC-V toolchain..."
# The system gcc-riscv64-linux-gnu should work fine for xv6
# Add symlinks for compatibility with Makefile expectations
if [ ! -f "/usr/local/bin/riscv64-unknown-elf-gcc" ]; then
    sudo ln -sf /usr/bin/riscv64-linux-gnu-gcc /usr/local/bin/riscv64-unknown-elf-gcc
    sudo ln -sf /usr/bin/riscv64-linux-gnu-ld /usr/local/bin/riscv64-unknown-elf-ld
    sudo ln -sf /usr/bin/riscv64-linux-gnu-objcopy /usr/local/bin/riscv64-unknown-elf-objcopy
    sudo ln -sf /usr/bin/riscv64-linux-gnu-objdump /usr/local/bin/riscv64-unknown-elf-objdump
fi

# Verify installation
echo "Verifying toolchain installation..."
riscv64-linux-gnu-gcc --version | head -n1

# Navigate to workspace
cd /workspaces/*/ 2>/dev/null || cd "$GITHUB_WORKSPACE" || true

# Test build
echo "Testing xv6 build..."
make clean 2>/dev/null || true

echo ""
echo "Setup complete! You can now build and run xv6:"
echo "   make qemu"
echo ""
echo "To exit QEMU, press: Ctrl-A then X"
echo ""
