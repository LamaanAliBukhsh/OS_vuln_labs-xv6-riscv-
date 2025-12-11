#!/bin/bash
set -e

echo "Setting up xv6 RISC-V Development Environment..."

sudo apt-get update
sudo apt-get install -y \
    git \
    build-essential \
    gdb-multiarch \
    gcc-riscv64-linux-gnu \
    binutils-riscv64-linux-gnu \
    qemu-system-misc \
    bc

sudo ln -sf /usr/bin/riscv64-linux-gnu-gcc /usr/bin/riscv64-unknown-elf-gcc
sudo ln -sf /usr/bin/riscv64-linux-gnu-ld /usr/bin/riscv64-unknown-elf-ld
sudo ln -sf /usr/bin/riscv64-linux-gnu-objcopy /usr/bin/riscv64-unknown-elf-objcopy
sudo ln -sf /usr/bin/riscv64-linux-gnu-objdump /usr/bin/riscv64-unknown-elf-objdump
sudo ln -sf /usr/bin/riscv64-linux-gnu-as /usr/bin/riscv64-unknown-elf-as

echo ""
echo "Setup complete! Run: make qemu"
echo "To exit QEMU: Ctrl-A then X"
echo ""
