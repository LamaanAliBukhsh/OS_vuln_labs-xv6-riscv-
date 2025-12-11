#!/bin/bash
set -e

echo "Setting up xv6 RISC-V Development Environment..."

# Update package list
echo "Updating package list..."
sudo apt-get update

# Install dependencies (including QEMU from default repos)
echo "Installing dependencies..."
sudo apt-get install -y \
    git \
    build-essential \
    gdb-multiarch \
    gcc-riscv64-linux-gnu \
    binutils-riscv64-linux-gnu \
    qemu-system-misc \
    bc

# Verify QEMU installation
echo "Verifying QEMU installation..."
qemu-system-riscv64 --version

# Set up RISC-V toolchain symlinks
echo "Setting up RISC-V toolchain..."
if [ ! -f "/usr/bin/riscv64-unknown-elf-gcc" ]; then
    sudo ln -sf /usr/bin/riscv64-linux-gnu-gcc /usr/bin/riscv64-unknown-elf-gcc
    sudo ln -sf /usr/bin/riscv64-linux-gnu-ld /usr/bin/riscv64-unknown-elf-ld
    sudo ln -sf /usr/bin/riscv64-linux-gnu-objcopy /usr/bin/riscv64-unknown-elf-objcopy
    sudo ln -sf /usr/bin/riscv64-linux-gnu-objdump /usr/bin/riscv64-unknown-elf-objdump
    sudo ln -sf /usr/bin/riscv64-linux-gnu-as /usr/bin/riscv64-unknown-elf-as
fi

# Verify toolchain
echo "Verifying toolchain..."
riscv64-linux-gnu-gcc --version | head -n1

echo ""
echo "Setup complete! Run: make qemu"
echo "To exit QEMU: Ctrl-A then X"
echo ""
